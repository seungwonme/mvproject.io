-- ============================================
-- 주문 테이블 생성
-- ============================================

-- 주문 상태 타입
CREATE TYPE order_status AS ENUM (
  'pending',    -- 결제 대기
  'paid',       -- 결제 완료
  'shipping',   -- 배송 중
  'delivered',  -- 배송 완료
  'cancelled'   -- 취소
);

CREATE TABLE orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  order_number TEXT NOT NULL UNIQUE,
  status order_status NOT NULL DEFAULT 'pending',
  total_amount INTEGER NOT NULL CHECK (total_amount >= 0),
  
  -- 배송 정보
  shipping_name TEXT,
  shipping_phone TEXT,
  shipping_address TEXT,
  shipping_memo TEXT,
  
  -- 결제 정보 (토스페이먼츠)
  payment_key TEXT,
  payment_method TEXT,
  paid_at TIMESTAMPTZ,
  
  -- 타임스탬프
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 인덱스 생성
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_order_number ON orders(order_number);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created_at ON orders(created_at DESC);

-- updated_at 자동 업데이트 트리거
CREATE OR REPLACE FUNCTION update_orders_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_orders_updated_at
  BEFORE UPDATE ON orders
  FOR EACH ROW
  EXECUTE FUNCTION update_orders_updated_at();

-- 코멘트
COMMENT ON TABLE orders IS '주문 정보';
COMMENT ON COLUMN orders.order_number IS '주문 번호 (고유)';
COMMENT ON COLUMN orders.status IS '주문 상태: pending, paid, shipping, delivered, cancelled';
COMMENT ON COLUMN orders.total_amount IS '총 결제 금액 (원)';
COMMENT ON COLUMN orders.payment_key IS '토스페이먼츠 결제 키';
COMMENT ON COLUMN orders.payment_method IS '결제 수단 (카드, 계좌이체 등)';
