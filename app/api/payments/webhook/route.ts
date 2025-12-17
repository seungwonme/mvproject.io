/**
 * @file app/api/payments/webhook/route.ts
 * @description 토스페이먼츠 웹훅 처리 API
 * 
 * 결제 상태 변경 시 토스페이먼츠에서 호출하는 웹훅 엔드포인트입니다.
 * 결제 취소, 환불 등의 이벤트를 처리합니다.
 */

import { NextResponse } from 'next/server';
import { createServiceRoleClient } from '@/lib/supabase/service-role';

const TOSS_SECRET_KEY = process.env.TOSS_SECRET_KEY;

// 웹훅 시크릿 검증 (프로덕션에서 설정)
// const WEBHOOK_SECRET = process.env.TOSS_WEBHOOK_SECRET;

export async function POST(request: Request) {
  try {
    const body = await request.json();
    
    console.log('토스 웹훅 수신:', JSON.stringify(body, null, 2));

    const { eventType, data } = body;

    // 서비스 역할 클라이언트 사용 (웹훅은 인증 없이 호출됨)
    const supabase = createServiceRoleClient();

    switch (eventType) {
      case 'PAYMENT.DONE': {
        // 결제 완료 (이미 confirm에서 처리하지만, 백업용)
        const { orderId, paymentKey, method } = data;
        
        await supabase
          .from('orders')
          .update({
            status: 'paid',
            payment_key: paymentKey,
            payment_method: method,
            paid_at: new Date().toISOString(),
          })
          .eq('order_number', orderId);
        break;
      }

      case 'PAYMENT.CANCELED': {
        // 결제 취소
        const { orderId, cancels } = data;
        const latestCancel = cancels?.[cancels.length - 1];
        
        await supabase
          .from('orders')
          .update({
            status: 'cancelled',
          })
          .eq('order_number', orderId);
        
        console.log(`주문 ${orderId} 취소됨:`, latestCancel?.cancelReason);
        break;
      }

      case 'PAYMENT.PARTIAL_CANCELED': {
        // 부분 취소
        const { orderId, cancels, totalAmount, balanceAmount } = data;
        
        console.log(`주문 ${orderId} 부분 취소: 총액 ${totalAmount}, 잔액 ${balanceAmount}`);
        break;
      }

      default:
        console.log('처리되지 않은 이벤트 타입:', eventType);
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('웹훅 처리 오류:', error);
    return NextResponse.json(
      { success: false, error: '웹훅 처리 중 오류 발생' },
      { status: 500 }
    );
  }
}
