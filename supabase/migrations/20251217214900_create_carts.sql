-- ============================================
-- 장바구니 테이블 생성
-- ============================================

CREATE TABLE carts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity > 0),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(user_id, product_id)
);

-- 인덱스 생성
CREATE INDEX idx_carts_user_id ON carts(user_id);
CREATE INDEX idx_carts_product_id ON carts(product_id);

-- updated_at 자동 업데이트 트리거
CREATE OR REPLACE FUNCTION update_carts_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_carts_updated_at
  BEFORE UPDATE ON carts
  FOR EACH ROW
  EXECUTE FUNCTION update_carts_updated_at();

-- 코멘트
COMMENT ON TABLE carts IS '사용자 장바구니';
COMMENT ON COLUMN carts.user_id IS '사용자 ID (users 테이블 참조)';
COMMENT ON COLUMN carts.product_id IS '상품 ID (products 테이블 참조)';
COMMENT ON COLUMN carts.quantity IS '수량 (1 이상)';
