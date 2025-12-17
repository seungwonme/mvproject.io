/**
 * @file app/admin/products/new/page.tsx
 * @description 상품 등록 페이지
 */

import { auth } from '@clerk/nextjs/server';
import { redirect } from 'next/navigation';
import { getCategories } from '@/actions/categories';
import { ProductForm } from '@/components/admin/product-form';

export const metadata = {
  title: '상품 등록 | 관리자',
  description: '새 상품을 등록합니다.',
};

export default async function NewProductPage() {
  const { userId } = await auth();

  if (!userId) {
    redirect('/sign-in');
  }

  const categories = await getCategories();

  return (
    <main className="min-h-screen bg-gray-50">
      <div className="max-w-4xl mx-auto px-4 py-8">
        <h1 className="text-2xl font-bold mb-8">상품 등록</h1>
        <ProductForm 
          categories={categories} 
          mode="create" 
        />
      </div>
    </main>
  );
}
