/**
 * @file components/header/hero-header.tsx
 * @description 홈페이지 히어로 헤더 컴포넌트
 *
 * 중세 세계지도 배경 위에 로고, 검색창, 상단 메뉴를 표시합니다.
 * 홈페이지에서만 사용되며, 다른 페이지에서는 기존 Navbar를 사용합니다.
 *
 * 주요 구성:
 * - TopBar: SNS 링크 + 사용자 메뉴
 * - SiteLogo: 해외직구멀티샵 로고
 * - SearchBar: 상품 검색창
 */

import { TopBar } from './top-bar';
import { SiteLogo } from './site-logo';
import { SearchBar } from './search-bar';

interface HeroHeaderProps {
  youtubeUrl?: string;
  instagramUrl?: string;
}

export function HeroHeader({
  youtubeUrl = '#',
  instagramUrl = '#'
}: HeroHeaderProps) {
  return (
    <header className="relative w-full min-h-[320px] sm:min-h-[380px] md:min-h-[420px]">
      {/* Background Image with Overlay */}
      <div
        className="absolute inset-0 bg-cover bg-center bg-no-repeat"
        style={{
          backgroundImage: `url('/images/hero-bg.jpg')`,
        }}
      >
        {/* Dark overlay for better text readability */}
        <div className="absolute inset-0 bg-gradient-to-b from-black/60 via-black/40 to-black/70" />
      </div>

      {/* Content */}
      <div className="relative z-10 flex flex-col h-full">
        {/* Top Bar */}
        <TopBar youtubeUrl={youtubeUrl} instagramUrl={instagramUrl} />

        {/* Main Content - Logo & Search */}
        <div className="flex-1 flex flex-col items-center justify-center px-4 py-8 sm:py-12">
          {/* Logo */}
          <SiteLogo className="mb-6 sm:mb-8" />

          {/* Search Bar */}
          <SearchBar className="w-full max-w-md sm:max-w-lg md:max-w-xl" />
        </div>
      </div>
    </header>
  );
}
