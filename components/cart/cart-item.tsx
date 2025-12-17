'use client';

/**
 * @file components/cart/cart-item.tsx
 * @description 장바구니 아이템 컴포넌트
 */

import Image from 'next/image';
import Link from 'next/link';
import { Minus, Plus, Trash2, Loader2 } from 'lucide-react';
import { useState, useTransition } from 'react';
import { Button } from '@/components/ui/button';
import { updateCartQuantity, removeFromCart } from '@/actions/cart';
import type { CartWithProduct } from '@/types';

interface CartItemProps {
  item: CartWithProduct;
}

export function CartItem({ item }: CartItemProps) {
  const [isPending, startTransition] = useTransition();
  const [quantity, setQuantity] = useState(item.quantity);

  const product = item.product;
  const price = product?.price_krw || 0;
  const subtotal = price * quantity;

  const formatPrice = (value: number) => {
    return new Intl.NumberFormat('ko-KR').format(value) + '원';
  };

  const handleQuantityChange = (newQuantity: number) => {
    if (newQuantity < 1) return;
    setQuantity(newQuantity);
    
    startTransition(async () => {
      const result = await updateCartQuantity(item.id, newQuantity);
      if (!result.success) {
        setQuantity(item.quantity); // 롤백
        alert(result.error);
      }
    });
  };

  const handleRemove = () => {
    if (!confirm('장바구니에서 삭제하시겠습니까?')) return;
    
    startTransition(async () => {
      const result = await removeFromCart(item.id);
      if (!result.success) {
        alert(result.error);
      }
    });
  };

  if (!product) {
    return null;
  }

  return (
    <div className="flex gap-4 p-4 bg-white rounded-xl border">
      {/* 상품 이미지 */}
      <Link 
        href={`/products/${product.slug}`}
        className="relative w-24 h-32 bg-gray-100 rounded-lg overflow-hidden flex-shrink-0"
      >
        {product.thumbnail_url ? (
          <Image
            src={product.thumbnail_url}
            alt={product.title}
            fill
            className="object-cover"
          />
        ) : (
          <div className="w-full h-full flex items-center justify-center">
            <span className="text-3xl opacity-30">📦</span>
          </div>
        )}
      </Link>

      {/* 상품 정보 */}
      <div className="flex-1 min-w-0">
        <Link 
          href={`/products/${product.slug}`}
          className="font-medium text-gray-900 hover:text-purple-600 line-clamp-2"
        >
          {product.title}
        </Link>
        
        <p className="text-sm text-gray-500 mt-1">
          {product.source_platform}
        </p>

        <div className="mt-2">
          <span className="text-lg font-bold text-purple-600">
            {formatPrice(price)}
          </span>
        </div>

        {/* 수량 조절 */}
        <div className="flex items-center justify-between mt-3">
          <div className="flex items-center gap-2">
            <Button
              variant="outline"
              size="icon"
              className="h-8 w-8"
              onClick={() => handleQuantityChange(quantity - 1)}
              disabled={isPending || quantity <= 1}
            >
              <Minus className="w-4 h-4" />
            </Button>
            <span className="w-10 text-center font-medium">
              {isPending ? <Loader2 className="w-4 h-4 animate-spin mx-auto" /> : quantity}
            </span>
            <Button
              variant="outline"
              size="icon"
              className="h-8 w-8"
              onClick={() => handleQuantityChange(quantity + 1)}
              disabled={isPending}
            >
              <Plus className="w-4 h-4" />
            </Button>
          </div>

          <Button
            variant="ghost"
            size="icon"
            className="text-gray-400 hover:text-red-500"
            onClick={handleRemove}
            disabled={isPending}
          >
            <Trash2 className="w-5 h-5" />
          </Button>
        </div>
      </div>

      {/* 소계 */}
      <div className="text-right flex-shrink-0">
        <p className="text-sm text-gray-500">소계</p>
        <p className="font-bold text-gray-900">{formatPrice(subtotal)}</p>
      </div>
    </div>
  );
}
