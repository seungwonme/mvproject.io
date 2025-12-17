'use client';

/**
 * @file components/checkout/checkout-form.tsx
 * @description 결제 폼 컴포넌트 (배송 정보 + 토스페이먼츠 위젯)
 */

import { useState, useEffect, useRef } from 'react';
import Image from 'next/image';
import { loadTossPayments, TossPaymentsWidgets } from '@tosspayments/tosspayments-sdk';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import type { CartWithProduct } from '@/types';

interface CheckoutFormProps {
  cartItems: CartWithProduct[];
  subtotal: number;
  shippingFee: number;
  totalAmount: number;
}

interface ShippingInfo {
  name: string;
  phone: string;
  address: string;
  memo: string;
}

export function CheckoutForm({ 
  cartItems, 
  subtotal, 
  shippingFee, 
  totalAmount 
}: CheckoutFormProps) {
  const [isLoading, setIsLoading] = useState(false);
  const [shippingInfo, setShippingInfo] = useState<ShippingInfo>({
    name: '',
    phone: '',
    address: '',
    memo: '',
  });
  const [widgets, setWidgets] = useState<TossPaymentsWidgets | null>(null);
  const [isWidgetReady, setIsWidgetReady] = useState(false);
  const paymentMethodsRef = useRef<HTMLDivElement>(null);
  const agreementRef = useRef<HTMLDivElement>(null);

  const formatPrice = (value: number) => {
    return new Intl.NumberFormat('ko-KR').format(value) + '원';
  };

  // 토스페이먼츠 위젯 초기화
  useEffect(() => {
    const clientKey = process.env.NEXT_PUBLIC_TOSS_CLIENT_KEY;
    
    if (!clientKey) {
      console.error('토스페이먼츠 클라이언트 키가 설정되지 않았습니다.');
      return;
    }

    const initTossPayments = async () => {
      try {
        const tossPayments = await loadTossPayments(clientKey);
        const customerKey = `customer_${Date.now()}`; // 고유 고객 키
        
        const widgetsInstance = tossPayments.widgets({
          customerKey,
        });

        // 결제 금액 설정
        await widgetsInstance.setAmount({
          currency: 'KRW',
          value: totalAmount,
        });

        setWidgets(widgetsInstance);
      } catch (error) {
        console.error('토스페이먼츠 초기화 오류:', error);
      }
    };

    initTossPayments();
  }, [totalAmount]);

  // 위젯 렌더링
  useEffect(() => {
    if (!widgets || !paymentMethodsRef.current || !agreementRef.current) return;

    const renderWidgets = async () => {
      try {
        // 결제 수단 위젯 렌더링
        await widgets.renderPaymentMethods({
          selector: '#payment-methods',
          variantKey: 'DEFAULT',
        });

        // 약관 동의 위젯 렌더링
        await widgets.renderAgreement({
          selector: '#agreement',
          variantKey: 'AGREEMENT',
        });

        setIsWidgetReady(true);
      } catch (error) {
        console.error('위젯 렌더링 오류:', error);
      }
    };

    renderWidgets();
  }, [widgets]);

  const handleInputChange = (field: keyof ShippingInfo, value: string) => {
    setShippingInfo(prev => ({ ...prev, [field]: value }));
  };

  const validateForm = (): boolean => {
    if (!shippingInfo.name.trim()) {
      alert('받는 분 이름을 입력해주세요.');
      return false;
    }
    if (!shippingInfo.phone.trim()) {
      alert('연락처를 입력해주세요.');
      return false;
    }
    if (!shippingInfo.address.trim()) {
      alert('배송 주소를 입력해주세요.');
      return false;
    }
    return true;
  };

  const handlePayment = async () => {
    if (!validateForm() || !widgets || !isWidgetReady) return;

    setIsLoading(true);

    try {
      // 주문 생성 API 호출
      const orderResponse = await fetch('/api/payments/request', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          cartItems: cartItems.map(item => ({
            productId: item.product_id,
            quantity: item.quantity,
          })),
          shippingInfo,
          totalAmount,
        }),
      });

      if (!orderResponse.ok) {
        const error = await orderResponse.json();
        throw new Error(error.message || '주문 생성에 실패했습니다.');
      }

      const { orderId, orderNumber } = await orderResponse.json();

      // 토스페이먼츠 결제 요청
      await widgets.requestPayment({
        orderId: orderNumber,
        orderName: cartItems.length > 1 
          ? `${cartItems[0].product?.title} 외 ${cartItems.length - 1}건`
          : cartItems[0].product?.title || '상품',
        successUrl: `${window.location.origin}/api/payments/confirm?orderId=${orderId}`,
        failUrl: `${window.location.origin}/checkout/fail`,
      });
    } catch (error) {
      console.error('결제 오류:', error);
      alert(error instanceof Error ? error.message : '결제 처리 중 오류가 발생했습니다.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="grid lg:grid-cols-2 gap-8">
      {/* 왼쪽: 배송 정보 입력 */}
      <div className="space-y-6">
        <div className="bg-white rounded-xl border p-6">
          <h2 className="text-lg font-bold mb-4">배송 정보</h2>
          
          <div className="space-y-4">
            <div>
              <Label htmlFor="name">받는 분 *</Label>
              <Input
                id="name"
                value={shippingInfo.name}
                onChange={(e) => handleInputChange('name', e.target.value)}
                placeholder="이름을 입력하세요"
              />
            </div>

            <div>
              <Label htmlFor="phone">연락처 *</Label>
              <Input
                id="phone"
                type="tel"
                value={shippingInfo.phone}
                onChange={(e) => handleInputChange('phone', e.target.value)}
                placeholder="010-0000-0000"
              />
            </div>

            <div>
              <Label htmlFor="address">배송 주소 *</Label>
              <Input
                id="address"
                value={shippingInfo.address}
                onChange={(e) => handleInputChange('address', e.target.value)}
                placeholder="주소를 입력하세요"
              />
            </div>

            <div>
              <Label htmlFor="memo">배송 메모</Label>
              <Textarea
                id="memo"
                value={shippingInfo.memo}
                onChange={(e) => handleInputChange('memo', e.target.value)}
                placeholder="배송 시 요청사항을 입력하세요 (선택)"
                rows={2}
              />
            </div>
          </div>
        </div>

        {/* 결제 수단 */}
        <div className="bg-white rounded-xl border p-6">
          <h2 className="text-lg font-bold mb-4">결제 수단</h2>
          <div id="payment-methods" ref={paymentMethodsRef} />
        </div>

        {/* 약관 동의 */}
        <div className="bg-white rounded-xl border p-6">
          <div id="agreement" ref={agreementRef} />
        </div>
      </div>

      {/* 오른쪽: 주문 요약 */}
      <div className="space-y-6">
        <div className="bg-white rounded-xl border p-6 sticky top-24">
          <h2 className="text-lg font-bold mb-4">주문 상품</h2>
          
          <div className="space-y-4 max-h-60 overflow-y-auto">
            {cartItems.map((item) => (
              <div key={item.id} className="flex gap-3">
                <div className="relative w-16 h-20 bg-gray-100 rounded overflow-hidden flex-shrink-0">
                  {item.product?.thumbnail_url ? (
                    <Image
                      src={item.product.thumbnail_url}
                      alt={item.product.title}
                      fill
                      className="object-cover"
                    />
                  ) : (
                    <div className="w-full h-full flex items-center justify-center">
                      <span className="text-xl opacity-30">📦</span>
                    </div>
                  )}
                </div>
                <div className="flex-1 min-w-0">
                  <p className="font-medium text-sm line-clamp-2">{item.product?.title}</p>
                  <p className="text-sm text-gray-500">수량: {item.quantity}</p>
                  <p className="text-sm font-medium">
                    {formatPrice((item.product?.price_krw || 0) * item.quantity)}
                  </p>
                </div>
              </div>
            ))}
          </div>

          <hr className="my-4" />

          <div className="space-y-2 text-sm">
            <div className="flex justify-between">
              <span className="text-gray-600">상품 금액</span>
              <span>{formatPrice(subtotal)}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-600">배송비</span>
              <span>{shippingFee === 0 ? '무료' : formatPrice(shippingFee)}</span>
            </div>
            <hr />
            <div className="flex justify-between text-lg font-bold">
              <span>총 결제 금액</span>
              <span className="text-purple-600">{formatPrice(totalAmount)}</span>
            </div>
          </div>

          <Button
            className="w-full mt-6 bg-purple-600 hover:bg-purple-700"
            size="lg"
            onClick={handlePayment}
            disabled={isLoading || !isWidgetReady}
          >
            {isLoading ? '결제 처리 중...' : `${formatPrice(totalAmount)} 결제하기`}
          </Button>
        </div>
      </div>
    </div>
  );
}
