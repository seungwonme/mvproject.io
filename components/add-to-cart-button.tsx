'use client';

/**
 * @file components/add-to-cart-button.tsx
 * @description 장바구니 담기 버튼 컴포넌트
 */

import { useState, useTransition } from 'react';
import { ShoppingCart, Check, Loader2, ExternalLink } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { addToCart } from '@/actions/cart';
import { useUser } from '@clerk/nextjs';

interface AddToCartButtonProps {
  productId: string;
  priceKrw: number | null;
  sourceUrl: string;
  className?: string;
}

export function AddToCartButton({ 
  productId, 
  priceKrw, 
  sourceUrl,
  className = ''
}: AddToCartButtonProps) {
  const { isSignedIn } = useUser();
  const [isPending, startTransition] = useTransition();
  const [isAdded, setIsAdded] = useState(false);

  // 직접 구매 불가능 (외부 링크만)
  if (!priceKrw) {
    return (
      <a
        href={sourceUrl}
        target="_blank"
        rel="noopener noreferrer"
        className={className}
      >
        <Button className="w-full bg-green-600 hover:bg-green-700" size="lg">
          <ExternalLink className="w-5 h-5 mr-2" />
          구매하러 가기
        </Button>
      </a>
    );
  }

  const handleAddToCart = () => {
    if (!isSignedIn) {
      alert('로그인이 필요합니다.');
      return;
    }

    startTransition(async () => {
      const result = await addToCart(productId, 1);
      
      if (result.success) {
        setIsAdded(true);
        setTimeout(() => setIsAdded(false), 2000);
      } else {
        alert(result.error);
      }
    });
  };

  return (
    <div className={className}>
      <Button 
        className={`w-full ${isAdded ? 'bg-green-600 hover:bg-green-700' : 'bg-purple-600 hover:bg-purple-700'}`}
        size="lg"
        onClick={handleAddToCart}
        disabled={isPending}
      >
        {isPending ? (
          <>
            <Loader2 className="w-5 h-5 mr-2 animate-spin" />
            추가 중...
          </>
        ) : isAdded ? (
          <>
            <Check className="w-5 h-5 mr-2" />
            장바구니에 담김
          </>
        ) : (
          <>
            <ShoppingCart className="w-5 h-5 mr-2" />
            장바구니 담기
          </>
        )}
      </Button>
    </div>
  );
}
