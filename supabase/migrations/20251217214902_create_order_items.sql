-- ============================================
-- 주문 상품 테이블 생성
-- ============================================

CREATE TABLE order_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  product_id UUID NOT NULL REFERENCES products(id),
  
  -- 주문 시점의 상품 정보 (스냅샷)
  product_title TEXT NOT NULL,
  product_thumbnail TEXT,
  price INTEGER NOT NULL CHECK (price >= 0),
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity > 0),
  
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 인덱스 생성
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- 코멘트
COMMENT ON TABLE order_items IS '주문 상품 (주문 시점의 상품 정보 스냅샷 포함)';
COMMENT ON COLUMN order_items.product_title IS '주문 시점의 상품명';
COMMENT ON COLUMN order_items.product_thumbnail IS '주문 시점의 상품 썸네일';
COMMENT ON COLUMN order_items.price IS '주문 시점의 상품 가격 (원)';
COMMENT ON COLUMN order_items.quantity IS '주문 수량';
