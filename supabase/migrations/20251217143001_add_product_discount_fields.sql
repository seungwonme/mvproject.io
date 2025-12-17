-- ============================================
-- products 테이블에 할인율, 구매자수 필드 추가
-- ============================================
-- 
-- discount_rate: 할인율 (0-100, 정수)
-- purchase_count: 구매자 수
--

ALTER TABLE products 
  ADD COLUMN IF NOT EXISTS discount_rate INTEGER DEFAULT 0,
  ADD COLUMN IF NOT EXISTS purchase_count INTEGER DEFAULT 0;

-- 유효성 체크 제약조건 추가
ALTER TABLE products 
  ADD CONSTRAINT check_discount_rate CHECK (discount_rate >= 0 AND discount_rate <= 100);

ALTER TABLE products 
  ADD CONSTRAINT check_purchase_count CHECK (purchase_count >= 0);

-- 인덱스 추가 (신상품 조회 최적화)
CREATE INDEX IF NOT EXISTS idx_products_created_at ON products(created_at DESC);
