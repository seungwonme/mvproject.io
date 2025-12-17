/**
 * @file components/header/top-bar.tsx
 * @description 상단 바 컴포넌트 (SNS 링크 + 사용자 메뉴)
 *
 * 좌측: YouTube, Instagram 링크
 * 우측: 로그인, 회원가입, 장바구니, 주문조회, 마이쇼핑
 */

'use client';

import Link from 'next/link';
import { SignedIn, SignedOut, SignInButton, SignUpButton, UserButton } from '@clerk/nextjs';
import { Youtube, Instagram, ShoppingCart, Package, User, Menu, X } from 'lucide-react';
import { useState } from 'react';

interface TopBarProps {
  youtubeUrl?: string;
  instagramUrl?: string;
}

export function TopBar({ 
  youtubeUrl = '#', 
  instagramUrl = '#' 
}: TopBarProps) {
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  const handleNotReady = (feature: string) => {
    alert(`${feature} 기능은 준비 중입니다.`);
  };

  return (
    <div className="w-full">
      {/* Desktop Top Bar */}
      <div className="hidden md:flex justify-between items-center px-4 py-2 text-sm text-white/90">
        {/* Left: SNS Links */}
        <div className="flex items-center gap-3">
          <a
            href={youtubeUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="hover:text-white transition-colors"
            aria-label="YouTube"
          >
            <Youtube className="w-5 h-5" />
          </a>
          <a
            href={instagramUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="hover:text-white transition-colors"
            aria-label="Instagram"
          >
            <Instagram className="w-5 h-5" />
          </a>
        </div>

        {/* Right: User Menu */}
        <div className="flex items-center gap-1 text-xs">
          <SignedOut>
            <SignInButton mode="modal">
              <button className="px-2 py-1 hover:text-white transition-colors">
                로그인
              </button>
            </SignInButton>
            <span className="text-white/50">|</span>
            <SignUpButton mode="modal">
              <button className="px-2 py-1 hover:text-white transition-colors">
                회원가입
              </button>
            </SignUpButton>
          </SignedOut>
          <SignedIn>
            <UserButton 
              afterSignOutUrl="/"
              appearance={{
                elements: {
                  avatarBox: "w-6 h-6"
                }
              }}
            />
          </SignedIn>
          <span className="text-white/50">|</span>
          <button 
            onClick={() => handleNotReady('장바구니')}
            className="px-2 py-1 hover:text-white transition-colors flex items-center gap-1"
          >
            <ShoppingCart className="w-3.5 h-3.5" />
            장바구니
          </button>
          <span className="text-white/50">|</span>
          <button 
            onClick={() => handleNotReady('주문조회')}
            className="px-2 py-1 hover:text-white transition-colors flex items-center gap-1"
          >
            <Package className="w-3.5 h-3.5" />
            주문조회
          </button>
          <span className="text-white/50">|</span>
          <Link 
            href="/my"
            className="px-2 py-1 hover:text-white transition-colors flex items-center gap-1"
          >
            <User className="w-3.5 h-3.5" />
            마이쇼핑
          </Link>
        </div>
      </div>

      {/* Mobile Top Bar */}
      <div className="md:hidden flex justify-between items-center px-4 py-2">
        {/* Left: SNS Links */}
        <div className="flex items-center gap-3 text-white/90">
          <a
            href={youtubeUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="hover:text-white transition-colors"
            aria-label="YouTube"
          >
            <Youtube className="w-5 h-5" />
          </a>
          <a
            href={instagramUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="hover:text-white transition-colors"
            aria-label="Instagram"
          >
            <Instagram className="w-5 h-5" />
          </a>
        </div>

        {/* Right: Mobile Menu Button */}
        <button
          onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
          className="text-white/90 hover:text-white p-2"
          aria-label="메뉴"
        >
          {isMobileMenuOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
        </button>
      </div>

      {/* Mobile Menu Dropdown */}
      {isMobileMenuOpen && (
        <div className="md:hidden bg-black/80 backdrop-blur-sm border-t border-white/10">
          <div className="flex flex-col px-4 py-3 gap-2 text-sm text-white/90">
            <SignedOut>
              <SignInButton mode="modal">
                <button className="text-left py-2 hover:text-white transition-colors">
                  로그인
                </button>
              </SignInButton>
              <SignUpButton mode="modal">
                <button className="text-left py-2 hover:text-white transition-colors">
                  회원가입
                </button>
              </SignUpButton>
            </SignedOut>
            <SignedIn>
              <div className="flex items-center gap-2 py-2">
                <UserButton 
                  afterSignOutUrl="/"
                  appearance={{
                    elements: {
                      avatarBox: "w-6 h-6"
                    }
                  }}
                />
                <span>내 계정</span>
              </div>
            </SignedIn>
            <button 
              onClick={() => handleNotReady('장바구니')}
              className="text-left py-2 hover:text-white transition-colors flex items-center gap-2"
            >
              <ShoppingCart className="w-4 h-4" />
              장바구니
            </button>
            <button 
              onClick={() => handleNotReady('주문조회')}
              className="text-left py-2 hover:text-white transition-colors flex items-center gap-2"
            >
              <Package className="w-4 h-4" />
              주문조회
            </button>
            <Link 
              href="/my"
              className="py-2 hover:text-white transition-colors flex items-center gap-2"
              onClick={() => setIsMobileMenuOpen(false)}
            >
              <User className="w-4 h-4" />
              마이쇼핑
            </Link>
          </div>
        </div>
      )}
    </div>
  );
}
