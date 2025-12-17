/**
 * @file components/home/todays-new-section.tsx
 * @description 오늘의 신상품 섹션 컴포넌트
 *
 * 홈페이지 CategoryNavbar 아래에 표시되는 최신 상품 섹션입니다.
 *
 * 구성:
 * - 제목: "오늘의 신상품 Today's NEW" (캐릭터 아이콘 포함)
 * - 상품 목록: 가로 1줄 (4개)
 * - 하단 버튼: "+ 모두보기" (초록색 테두리)
 *
 * @dependencies
 * - components/product-card: 상품 카드
 * - lucide-react: 아이콘
 */

import Link from 'next/link';
import { Plus, Sparkles } from 'lucide-react';
import { ProductCard, ProductCardSkeleton } from '@/components/product-card';
import type { ProductWithCategory } from '@/types';

interface TodaysNewSectionProps {
  products: ProductWithCategory[];
}

export function TodaysNewSection({ products }: TodaysNewSectionProps) {
  return (
    <section className="py-12 bg-white">
      <div className="max-w-7xl mx-auto px-4">
        {/* 섹션 제목 */}
        <div className="flex items-center justify-center gap-3 mb-8">
          {/* 캐릭터 아이콘 */}
          <div className="w-10 h-10 bg-gradient-to-br from-yellow-400 to-orange-500 rounded-full flex items-center justify-center shadow-md">
            <Sparkles className="w-5 h-5 text-white" />
          </div>
          
          {/* 제목 */}
          <h2 className="text-2xl sm:text-3xl font-bold">
            <span className="text-gray-900">오늘의 신상품</span>
            <span className="text-gray-400 ml-2 font-normal">Today&apos;s NEW</span>
          </h2>
        </div>

        {/* 상품 목록 */}
        {products.length > 0 ? (
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4">
            {products.map((product) => (
              <ProductCard key={product.id} product={product} />
            ))}
          </div>
        ) : (
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4">
            {[...Array(4)].map((_, i) => (
              <ProductCardSkeleton key={i} />
            ))}
          </div>
        )}

        {/* 모두보기 버튼 */}
        <div className="flex justify-center mt-8">
          <Link
            href="/products?sort=newest"
            className="inline-flex items-center gap-2 px-8 py-3 border-2 border-green-500 text-green-600 rounded-full font-semibold hover:bg-green-50 transition-colors"
          >
            <Plus className="w-5 h-5" />
            모두보기
          </Link>
        </div>
      </div>
    </section>
  );
}

/**
 * 스켈레톤 로딩 상태
 */
export function TodaysNewSectionSkeleton() {
  return (
    <section className="py-12 bg-white">
      <div className="max-w-7xl mx-auto px-4">
        {/* 섹션 제목 스켈레톤 */}
        <div className="flex items-center justify-center gap-3 mb-8">
          <div className="w-10 h-10 bg-gray-200 rounded-full animate-pulse" />
          <div className="h-8 w-64 bg-gray-200 rounded animate-pulse" />
        </div>

        {/* 상품 목록 스켈레톤 */}
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4">
          {[...Array(4)].map((_, i) => (
            <ProductCardSkeleton key={i} />
          ))}
        </div>

        {/* 버튼 스켈레톤 */}
        <div className="flex justify-center mt-8">
          <div className="h-12 w-40 bg-gray-200 rounded-full animate-pulse" />
        </div>
      </div>
    </section>
  );
}
