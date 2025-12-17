'use server';

/**
 * @file actions/cart.ts
 * @description 장바구니 관련 Server Actions
 *
 * 장바구니 조회, 추가, 수량 변경, 삭제 등의 서버 액션을 제공합니다.
 * 직접 구매 가능 상품(price_krw가 있는 상품)만 장바구니에 추가할 수 있습니다.
 */

import { createClerkSupabaseClient } from '@/lib/supabase/server';
import { auth } from '@clerk/nextjs/server';
import { revalidatePath } from 'next/cache';
import type { CartWithProduct } from '@/types';

/**
 * 장바구니 목록 조회
 */
export async function getCartItems(): Promise<CartWithProduct[]> {
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

  const { data, error } = await supabase
    .from('carts')
    .select(`
      *,
      product:products(*)
    `)
    .eq('user_id', userData.id)
    .order('created_at', { ascending: false });

  if (error) {
    console.error('Error fetching cart:', error);
    return [];
  }

  return (data as CartWithProduct[]) || [];
}

/**
 * 장바구니 아이템 개수 조회
 */
export async function getCartCount(): Promise<number> {
  const { userId } = await auth();

  if (!userId) {
    return 0;
  }

  const supabase = await createClerkSupabaseClient();

  // 사용자 확인
  const { data: userData } = await supabase
    .from('users')
    .select('id')
    .eq('clerk_id', userId)
    .single();

  if (!userData) {
    return 0;
  }

  const { count, error } = await supabase
    .from('carts')
    .select('*', { count: 'exact', head: true })
    .eq('user_id', userData.id);

  if (error) {
    console.error('Error fetching cart count:', error);
    return 0;
  }

  return count || 0;
}

/**
 * 장바구니에 상품 추가
 */
export async function addToCart(
  productId: string,
  quantity: number = 1
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

  // 상품 확인 (직접 구매 가능 여부 체크)
  const { data: productData } = await supabase
    .from('products')
    .select('id, price_krw, is_active')
    .eq('id', productId)
    .single();

  if (!productData) {
    return { success: false, error: '상품을 찾을 수 없습니다.' };
  }

  if (!productData.is_active) {
    return { success: false, error: '판매 중지된 상품입니다.' };
  }

  if (!productData.price_krw) {
    return { success: false, error: '직접 구매가 불가능한 상품입니다. 외부 링크를 이용해주세요.' };
  }

  // 이미 장바구니에 있는지 확인
  const { data: existing } = await supabase
    .from('carts')
    .select('id, quantity')
    .eq('user_id', userData.id)
    .eq('product_id', productId)
    .single();

  if (existing) {
    // 이미 있으면 수량 증가
    const { error } = await supabase
      .from('carts')
      .update({ quantity: existing.quantity + quantity })
      .eq('id', existing.id);

    if (error) {
      console.error('Error updating cart quantity:', error);
      return { success: false, error: '장바구니 수량 변경에 실패했습니다.' };
    }
  } else {
    // 없으면 새로 추가
    const { error } = await supabase.from('carts').insert({
      user_id: userData.id,
      product_id: productId,
      quantity,
    });

    if (error) {
      console.error('Error adding to cart:', error);
      return { success: false, error: '장바구니 추가에 실패했습니다.' };
    }
  }

  revalidatePath('/cart');
  return { success: true };
}

/**
 * 장바구니 수량 변경
 */
export async function updateCartQuantity(
  cartId: string,
  quantity: number
): Promise<{ success: boolean; error?: string }> {
  const { userId } = await auth();

  if (!userId) {
    return { success: false, error: '로그인이 필요합니다.' };
  }

  if (quantity < 1) {
    return { success: false, error: '수량은 1개 이상이어야 합니다.' };
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

  // 장바구니 아이템 확인 (소유권 체크)
  const { data: cartItem } = await supabase
    .from('carts')
    .select('id')
    .eq('id', cartId)
    .eq('user_id', userData.id)
    .single();

  if (!cartItem) {
    return { success: false, error: '장바구니 아이템을 찾을 수 없습니다.' };
  }

  const { error } = await supabase
    .from('carts')
    .update({ quantity })
    .eq('id', cartId);

  if (error) {
    console.error('Error updating cart quantity:', error);
    return { success: false, error: '수량 변경에 실패했습니다.' };
  }

  revalidatePath('/cart');
  return { success: true };
}

/**
 * 장바구니에서 상품 제거
 */
export async function removeFromCart(
  cartId: string
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

  const { error } = await supabase
    .from('carts')
    .delete()
    .eq('id', cartId)
    .eq('user_id', userData.id);

  if (error) {
    console.error('Error removing from cart:', error);
    return { success: false, error: '장바구니에서 제거에 실패했습니다.' };
  }

  revalidatePath('/cart');
  return { success: true };
}

/**
 * 장바구니 비우기
 */
export async function clearCart(): Promise<{ success: boolean; error?: string }> {
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

  const { error } = await supabase
    .from('carts')
    .delete()
    .eq('user_id', userData.id);

  if (error) {
    console.error('Error clearing cart:', error);
    return { success: false, error: '장바구니 비우기에 실패했습니다.' };
  }

  revalidatePath('/cart');
  return { success: true };
}

/**
 * 상품이 장바구니에 있는지 확인
 */
export async function isInCart(productId: string): Promise<boolean> {
  const { userId } = await auth();

  if (!userId) {
    return false;
  }

  const supabase = await createClerkSupabaseClient();

  // 사용자 확인
  const { data: userData } = await supabase
    .from('users')
    .select('id')
    .eq('clerk_id', userId)
    .single();

  if (!userData) {
    return false;
  }

  const { data } = await supabase
    .from('carts')
    .select('id')
    .eq('user_id', userData.id)
    .eq('product_id', productId)
    .single();

  return !!data;
}

/**
 * 장바구니 총 금액 계산
 */
export async function getCartTotal(): Promise<number> {
  const cartItems = await getCartItems();
  
  return cartItems.reduce((total, item) => {
    const price = item.product?.price_krw || 0;
    return total + (price * item.quantity);
  }, 0);
}
