'use client';

/**
 * @file components/orders/cancel-order-button.tsx
 * @description 주문 취소 버튼 컴포넌트
 */

import { useState, useTransition } from 'react';
import { X, Loader2 } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { cancelOrder } from '@/actions/orders';
import { useRouter } from 'next/navigation';

interface CancelOrderButtonProps {
  orderId: string;
}

export function CancelOrderButton({ orderId }: CancelOrderButtonProps) {
  const router = useRouter();
  const [isPending, startTransition] = useTransition();

  const handleCancel = () => {
    if (!confirm('정말 주문을 취소하시겠습니까?')) return;

    startTransition(async () => {
      const result = await cancelOrder(orderId);
      
      if (result.success) {
        alert('주문이 취소되었습니다.');
        router.refresh();
      } else {
        alert(result.error || '주문 취소에 실패했습니다.');
      }
    });
  };

  return (
    <Button
      variant="outline"
      size="sm"
      onClick={handleCancel}
      disabled={isPending}
      className="text-red-500 border-red-200 hover:bg-red-50"
    >
      {isPending ? (
        <>
          <Loader2 className="w-4 h-4 mr-1 animate-spin" />
          취소 중...
        </>
      ) : (
        <>
          <X className="w-4 h-4 mr-1" />
          주문 취소
        </>
      )}
    </Button>
  );
}
