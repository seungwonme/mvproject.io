/**
 * @file app/api/payments/confirm/route.ts
 * @description 결제 승인 API - 토스페이먼츠 결제 승인 및 주문 상태 업데이트
 */

import { NextResponse } from 'next/server';
import { createClerkSupabaseClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { clearCart } from '@/actions/cart';

const TOSS_SECRET_KEY = process.env.TOSS_SECRET_KEY;

export async function GET(request: Request) {
  try {
    const { userId } = await auth();

    if (!userId) {
      return NextResponse.redirect(new URL('/sign-in', request.url));
    }

    const { searchParams } = new URL(request.url);
    const paymentKey = searchParams.get('paymentKey');
    const orderId = searchParams.get('orderId');
    const amount = searchParams.get('amount');

    if (!paymentKey || !orderId || !amount) {
      return NextResponse.redirect(
        new URL('/checkout/fail?message=결제 정보가 누락되었습니다.', request.url)
      );
    }

    const supabase = await createClerkSupabaseClient();

    // 주문 조회
    const { data: order } = await supabase
      .from('orders')
      .select('*')
      .eq('id', orderId)
      .single();

    if (!order) {
      return NextResponse.redirect(
        new URL('/checkout/fail?message=주문을 찾을 수 없습니다.', request.url)
      );
    }

    // 금액 검증
    if (order.total_amount !== parseInt(amount)) {
      return NextResponse.redirect(
        new URL('/checkout/fail?message=결제 금액이 일치하지 않습니다.', request.url)
      );
    }

    // 토스페이먼츠 결제 승인 API 호출
    const confirmResponse = await fetch(
      'https://api.tosspayments.com/v1/payments/confirm',
      {
        method: 'POST',
        headers: {
          'Authorization': `Basic ${Buffer.from(`${TOSS_SECRET_KEY}:`).toString('base64')}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          paymentKey,
          orderId: order.order_number,
          amount: parseInt(amount),
        }),
      }
    );

    if (!confirmResponse.ok) {
      const errorData = await confirmResponse.json();
      console.error('토스 결제 승인 실패:', errorData);
      return NextResponse.redirect(
        new URL(`/checkout/fail?code=${errorData.code}&message=${encodeURIComponent(errorData.message)}`, request.url)
      );
    }

    const paymentData = await confirmResponse.json();

    // 주문 상태 업데이트
    const { error: updateError } = await supabase
      .from('orders')
      .update({
        status: 'paid',
        payment_key: paymentKey,
        payment_method: paymentData.method,
        paid_at: new Date().toISOString(),
      })
      .eq('id', orderId);

    if (updateError) {
      console.error('주문 상태 업데이트 오류:', updateError);
      // 결제는 성공했지만 DB 업데이트 실패 - 로그만 남기고 성공 처리
    }

    // 장바구니 비우기
    await clearCart();

    // 성공 페이지로 리다이렉트
    return NextResponse.redirect(
      new URL(`/checkout/success?orderNumber=${order.order_number}`, request.url)
    );
  } catch (error) {
    console.error('결제 승인 오류:', error);
    return NextResponse.redirect(
      new URL('/checkout/fail?message=결제 승인 처리 중 오류가 발생했습니다.', request.url)
    );
  }
}
