'use server';

/**
 * @file actions/orders.ts
 * @description 주문 관련 Server Actions
 *
 * 주문 목록 조회, 상세 조회, 취소 등의 서버 액션을 제공합니다.
 */

import { createClerkSupabaseClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { revalidatePath } from 'next/cache';
import type { Order, OrderItem, OrderWithItems } from '@/types';

/**
 * 내 주문 목록 조회
 */
export async function getMyOrders(): Promise<OrderWithItems[]> {
  const { userId } = await auth();

  if (!userId) {
    return [];
  }

  const supabase = await createClerkSupabaseClient();

  // 사용자 확인
  const { data: userData } = await supabase
    .from('users')
    .select('id')
    .eq('clerk_id', userId)
    .single();

  if (!userData) {
    return [];
  }

  // 주문 목록 조회 (주문 상품 포함)
  const { data: orders, error } = await supabase
    .from('orders')
    .select(`
      *,
      items:order_items(*)
    `)
    .eq('user_id', userData.id)
    .order('created_at', { ascending: false });

  if (error) {
    console.error('주문 목록 조회 오류:', error);
    return [];
  }

  return (orders as OrderWithItems[]) || [];
}

/**
 * 주문 상세 조회
 */
export async function getOrderDetail(orderId: string): Promise<OrderWithItems | null> {
  const { userId } = await auth();

  if (!userId) {
    return null;
  }

  const supabase = await createClerkSupabaseClient();

  // 사용자 확인
  const { data: userData } = await supabase
    .from('users')
    .select('id')
    .eq('clerk_id', userId)
    .single();

  if (!userData) {
    return null;
  }

  // 주문 상세 조회 (소유권 확인 포함)
  const { data: order, error } = await supabase
    .from('orders')
    .select(`
      *,
      items:order_items(*)
    `)
    .eq('id', orderId)
    .eq('user_id', userData.id)
    .single();

  if (error) {
    console.error('주문 상세 조회 오류:', error);
    return null;
  }

  return order as OrderWithItems;
}

/**
 * 주문 번호로 조회
 */
export async function getOrderByNumber(orderNumber: string): Promise<OrderWithItems | null> {
  const { userId } = await auth();

  if (!userId) {
    return null;
  }

  const supabase = await createClerkSupabaseClient();

  // 사용자 확인
  const { data: userData } = await supabase
    .from('users')
    .select('id')
    .eq('clerk_id', userId)
    .single();

  if (!userData) {
    return null;
  }

  const { data: order, error } = await supabase
    .from('orders')
    .select(`
      *,
      items:order_items(*)
    `)
    .eq('order_number', orderNumber)
    .eq('user_id', userData.id)
    .single();

  if (error) {
    console.error('주문 조회 오류:', error);
    return null;
  }

  return order as OrderWithItems;
}

/**
 * 주문 취소 (결제 전 주문만)
 */
export async function cancelOrder(
  orderId: string
): Promise<{ success: boolean; error?: string }> {
  const { userId } = await auth();

  if (!userId) {
    return { success: false, error: '로그인이 필요합니다.' };
  }

  const supabase = await createClerkSupabaseClient();

  // 사용자 확인
  const { data: userData } = await supabase
    .from('users')
    .select('id')
    .eq('clerk_id', userId)
    .single();

  if (!userData) {
    return { success: false, error: '사용자 정보를 찾을 수 없습니다.' };
  }

  // 주문 확인 (소유권 및 상태 체크)
  const { data: order } = await supabase
    .from('orders')
    .select('id, status')
    .eq('id', orderId)
    .eq('user_id', userData.id)
    .single();

  if (!order) {
    return { success: false, error: '주문을 찾을 수 없습니다.' };
  }

  if (order.status !== 'pending') {
    return { 
      success: false, 
      error: '결제 완료된 주문은 고객센터를 통해 취소해주세요.' 
    };
  }

  // 주문 취소
  const { error } = await supabase
    .from('orders')
    .update({ status: 'cancelled' })
    .eq('id', orderId);

  if (error) {
    console.error('주문 취소 오류:', error);
    return { success: false, error: '주문 취소에 실패했습니다.' };
  }

  revalidatePath('/my/orders');
  return { success: true };
}

/**
 * 주문 상태별 개수 조회
 */
export async function getOrderCounts(): Promise<{
  pending: number;
  paid: number;
  shipping: number;
  delivered: number;
  cancelled: number;
}> {
  const { userId } = await auth();

  if (!userId) {
    return { pending: 0, paid: 0, shipping: 0, delivered: 0, cancelled: 0 };
  }

  const supabase = await createClerkSupabaseClient();

  // 사용자 확인
  const { data: userData } = await supabase
    .from('users')
    .select('id')
    .eq('clerk_id', userId)
    .single();

  if (!userData) {
    return { pending: 0, paid: 0, shipping: 0, delivered: 0, cancelled: 0 };
  }

  const { data: orders } = await supabase
    .from('orders')
    .select('status')
    .eq('user_id', userData.id);

  if (!orders) {
    return { pending: 0, paid: 0, shipping: 0, delivered: 0, cancelled: 0 };
  }

  const counts = {
    pending: 0,
    paid: 0,
    shipping: 0,
    delivered: 0,
    cancelled: 0,
  };

  orders.forEach(order => {
    const status = order.status as keyof typeof counts;
    if (status in counts) {
      counts[status]++;
    }
  });

  return counts;
}
