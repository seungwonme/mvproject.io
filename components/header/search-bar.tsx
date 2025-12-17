/**
 * @file components/header/search-bar.tsx
 * @description 상품 검색창 컴포넌트
 *
 * 초록색 테두리와 돋보기 아이콘이 있는 검색창입니다.
 * 검색 시 /products?search=검색어 로 이동합니다.
 */

'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { Search } from 'lucide-react';

interface SearchBarProps {
  className?: string;
  placeholder?: string;
}

export function SearchBar({ 
  className, 
  placeholder = '상품을 검색하세요...' 
}: SearchBarProps) {
  const [query, setQuery] = useState('');
  const router = useRouter();

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (query.trim()) {
      router.push(`/products?search=${encodeURIComponent(query.trim())}`);
    }
  };

  return (
    <form onSubmit={handleSubmit} className={className}>
      <div className="relative flex items-center">
        <input
          type="text"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder={placeholder}
          className="w-full h-12 pl-4 pr-14 bg-black/70 text-white placeholder-gray-400 
                     border-2 border-green-500 rounded-lg
                     focus:outline-none focus:border-green-400 focus:ring-1 focus:ring-green-400
                     transition-colors"
        />
        <button
          type="submit"
          className="absolute right-0 h-12 w-12 flex items-center justify-center 
                     bg-green-500 hover:bg-green-600 rounded-r-lg
                     transition-colors"
          aria-label="검색"
        >
          <Search className="w-5 h-5 text-white" />
        </button>
      </div>
    </form>
  );
}
