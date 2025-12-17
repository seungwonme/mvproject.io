'use client';

/**
 * @file components/cart/cart-summary.tsx
 * @description 장바구니 결제 요약 컴포넌트
 */

import Link from 'next/link';
import { ShoppingBag } from 'lucide-react';
import { Button } from '@/components/ui/button';
import type { CartWithProduct } from '@/types';

interface CartSummaryProps {
  items: CartWithProduct[];
}

export function CartSummary({ items }: CartSummaryProps) {
  const formatPrice = (value: number) => {
    return new Intl.NumberFormat('ko-KR').format(value) + '원';
  };

  // 상품 금액 계산
  const subtotal = items.reduce((total, item) => {
    const price = item.product?.price_krw || 0;
    return total + (price * item.quantity);
  }, 0);

  // 배송비 (50,000원 이상 무료)
  const shippingFee = subtotal >= 50000 ? 0 : 3000;
  const freeShippingRemaining = subtotal >= 50000 ? 0 : 50000 - subtotal;

  // 총 결제 금액
  const total = subtotal + shippingFee;

  // 총 상품 개수
  const totalItems = items.reduce((count, item) => count + item.quantity, 0);

  return (
    <div className="bg-white rounded-xl border p-6 sticky top-24">
      <h2 className="text-lg font-bold mb-4">결제 요약</h2>

      <div className="space-y-3 text-sm">
        <div className="flex justify-between">
          <span className="text-gray-600">상품 금액</span>
          <span className="font-medium">{formatPrice(subtotal)}</span>
        </div>
        <div className="flex justify-between">
          <span className="text-gray-600">배송비</span>
          <span className="font-medium">
            {shippingFee === 0 ? (
              <span className="text-green-600">무료</span>
            ) : (
              formatPrice(shippingFee)
            )}
          </span>
        </div>

        {freeShippingRemaining > 0 && (
          <p className="text-xs text-purple-600 bg-purple-50 p-2 rounded">
            {formatPrice(freeShippingRemaining)} 더 담으면 무료배송!
          </p>
        )}

        <hr className="my-3" />

        <div className="flex justify-between text-base">
          <span className="font-bold">총 결제 금액</span>
          <span className="font-bold text-purple-600">{formatPrice(total)}</span>
        </div>
        <p className="text-xs text-gray-500">총 {totalItems}개 상품</p>
      </div>

      <Link href="/checkout" className="block mt-6">
        <Button 
          className="w-full bg-purple-600 hover:bg-purple-700"
          size="lg"
          disabled={items.length === 0}
        >
          <ShoppingBag className="w-5 h-5 mr-2" />
          결제하기
        </Button>
      </Link>

      <Link href="/products" className="block mt-3">
        <Button variant="outline" className="w-full">
          쇼핑 계속하기
        </Button>
      </Link>
    </div>
  );
}
