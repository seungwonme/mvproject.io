-- ============================================
-- 해외직구멀티샵 샘플 데이터 시드
-- ============================================
-- 실행 방법: Supabase SQL Editor에서 실행
-- ============================================

-- 기존 데이터 삭제 (순서 중요: FK 의존성)
TRUNCATE TABLE public.external_reviews CASCADE;
TRUNCATE TABLE public.products CASCADE;
TRUNCATE TABLE public.categories CASCADE;

-- ============================================
-- 1. 카테고리 (8개)
-- ============================================

INSERT INTO public.categories (id, name, slug, description, image_url, sort_order, is_active) VALUES
('11111111-1111-1111-1111-111111111101', '전자기기', 'electronics', '스마트폰, 태블릿, 이어폰, 스마트워치 등', 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=400', 1, true),
('11111111-1111-1111-1111-111111111102', '뷰티', 'beauty', '스킨케어, 메이크업, 헤어케어, 향수 등', 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400', 2, true),
('11111111-1111-1111-1111-111111111103', '패션', 'fashion', '의류, 신발, 가방, 액세서리 등', 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=400', 3, true),
('11111111-1111-1111-1111-111111111104', '건강식품', 'health', '비타민, 영양제, 프로틴, 다이어트 식품 등', 'https://images.unsplash.com/photo-1505576399279-565b52d4ac71?w=400', 4, true),
('11111111-1111-1111-1111-111111111105', '주방용품', 'kitchen', '조리도구, 식기, 수납용품, 소형가전 등', 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400', 5, true),
('11111111-1111-1111-1111-111111111106', '스포츠', 'sports', '운동기구, 스포츠웨어, 아웃도어 용품 등', 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400', 6, true),
('11111111-1111-1111-1111-111111111107', '유아용품', 'baby', '유아의류, 장난감, 유모차, 육아용품 등', 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=400', 7, true),
('11111111-1111-1111-1111-111111111108', '홈인테리어', 'home', '가구, 조명, 수납, 인테리어 소품 등', 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=400', 8, true);

-- ============================================
-- 2. 상품 (50개) - 전자기기 카테고리 (7개)
-- ============================================

INSERT INTO public.products (id, title, slug, description, thumbnail_url, video_url, images, original_price, currency, price_krw, source_platform, source_url, external_rating, external_review_count, category_id, tags, is_featured, is_active, view_count) VALUES
-- 전자기기 (7개)
('22222222-2222-2222-2222-222222222201', 'Apple AirPods Pro 2세대 USB-C', 'airpods-pro-2-usb-c', '액티브 노이즈 캔슬링, 적응형 오디오, 공간 음향 기능을 갖춘 프리미엄 무선 이어폰', 'https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', 'https://videos.pexels.com/video-files/5081219/5081219-sd_506_960_25fps.mp4', ARRAY['https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg'], 249.00, 'USD', 329000, 'amazon', 'https://amazon.com/dp/B0CHWRXH8B', 4.7, 45230, '11111111-1111-1111-1111-111111111101', ARRAY['애플', '이어폰', 'ANC', '무선'], true, true, 1520),

('22222222-2222-2222-2222-222222222202', 'Samsung Galaxy Buds2 Pro', 'galaxy-buds2-pro', '24비트 Hi-Fi 사운드와 인텔리전트 ANC를 갖춘 프리미엄 이어버드', 'https://images.pexels.com/photos/8534088/pexels-photo-8534088.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', 'https://videos.pexels.com/video-files/5081219/5081219-sd_506_960_25fps.mp4', ARRAY['https://images.pexels.com/photos/8534088/pexels-photo-8534088.jpeg'], 179.99, 'USD', 238000, 'amazon', 'https://amazon.com/dp/B0B2SH4CN6', 4.5, 12840, '11111111-1111-1111-1111-111111111101', ARRAY['삼성', '이어폰', 'ANC', '무선'], true, true, 890),

('22222222-2222-2222-2222-222222222203', 'Apple Watch Series 9 GPS 45mm', 'apple-watch-series-9-45mm', 'S9 SiP 칩, 더블 탭 제스처, 밝은 디스플레이를 갖춘 스마트워치', 'https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg'], 429.00, 'USD', 569000, 'amazon', 'https://amazon.com/dp/B0CHX9CY7W', 4.8, 8920, '11111111-1111-1111-1111-111111111101', ARRAY['애플', '스마트워치', '웨어러블'], true, true, 2100),

('22222222-2222-2222-2222-222222222204', 'Sony WH-1000XM5 무선 헤드폰', 'sony-wh1000xm5', '업계 최고 수준의 노이즈 캔슬링과 30시간 배터리를 갖춘 프리미엄 헤드폰', 'https://images.pexels.com/photos/3587478/pexels-photo-3587478.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', 'https://videos.pexels.com/video-files/4620563/4620563-sd_506_960_25fps.mp4', ARRAY['https://images.pexels.com/photos/3587478/pexels-photo-3587478.jpeg'], 348.00, 'USD', 459000, 'amazon', 'https://amazon.com/dp/B09XS7JWHH', 4.6, 23450, '11111111-1111-1111-1111-111111111101', ARRAY['소니', '헤드폰', 'ANC', '무선'], false, true, 1340),

('22222222-2222-2222-2222-222222222205', 'Anker 737 Power Bank 24000mAh', 'anker-737-powerbank', '140W 초고속 충전, 스마트 디스플레이를 갖춘 대용량 보조배터리', 'https://images.pexels.com/photos/4526407/pexels-photo-4526407.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/4526407/pexels-photo-4526407.jpeg'], 109.99, 'USD', 145000, 'amazon', 'https://amazon.com/dp/B09VPHVT2Z', 4.7, 5670, '11111111-1111-1111-1111-111111111101', ARRAY['앵커', '보조배터리', '충전기'], false, true, 780),

('22222222-2222-2222-2222-222222222206', 'Logitech MX Master 3S 무선 마우스', 'logitech-mx-master-3s', '8000 DPI 센서, 조용한 클릭, 멀티 디바이스 지원 프리미엄 마우스', 'https://images.pexels.com/photos/5082579/pexels-photo-5082579.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/5082579/pexels-photo-5082579.jpeg'], 99.99, 'USD', 132000, 'amazon', 'https://amazon.com/dp/B09HM94VDS', 4.8, 18920, '11111111-1111-1111-1111-111111111101', ARRAY['로지텍', '마우스', '무선', '사무용'], false, true, 560),

('22222222-2222-2222-2222-222222222207', 'iPad Pro 11인치 M4 칩', 'ipad-pro-11-m4', 'M4 칩, Ultra Retina XDR 디스플레이, Apple Pencil Pro 지원', 'https://images.pexels.com/photos/1334597/pexels-photo-1334597.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', 'https://videos.pexels.com/video-files/5081219/5081219-sd_506_960_25fps.mp4', ARRAY['https://images.pexels.com/photos/1334597/pexels-photo-1334597.jpeg'], 999.00, 'USD', 1329000, 'amazon', 'https://amazon.com/dp/B0D3J6L2ZC', 4.9, 3240, '11111111-1111-1111-1111-111111111101', ARRAY['애플', '태블릿', 'M4'], true, true, 3200),

-- 뷰티 (6개)
('22222222-2222-2222-2222-222222222208', 'La Mer 크렘 드 라 메르 모이스처라이저', 'la-mer-creme', '럭셔리 스킨케어의 대명사, 미라클 브로스 함유 크림', 'https://images.pexels.com/photos/3785147/pexels-photo-3785147.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/3785147/pexels-photo-3785147.jpeg'], 380.00, 'USD', 498000, 'amazon', 'https://amazon.com/dp/B00B3CZFUM', 4.6, 8920, '11111111-1111-1111-1111-111111111102', ARRAY['라메르', '크림', '보습', '럭셔리'], true, true, 1890),

('22222222-2222-2222-2222-222222222209', 'SK-II 피테라 에센스 230ml', 'sk2-pitera-essence', '90% 이상 피테라 함유, 맑고 투명한 피부를 위한 에센스', 'https://images.pexels.com/photos/4041392/pexels-photo-4041392.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/4041392/pexels-photo-4041392.jpeg'], 235.00, 'USD', 309000, 'amazon', 'https://amazon.com/dp/B00AYTKKZY', 4.7, 15670, '11111111-1111-1111-1111-111111111102', ARRAY['SK-II', '에센스', '피테라', '스킨케어'], true, true, 2340),

('22222222-2222-2222-2222-222222222210', 'Dyson Airwrap Complete Long', 'dyson-airwrap-complete', '열 손상 없이 스타일링, 코안다 에어플로우 기술', 'https://images.pexels.com/photos/3993449/pexels-photo-3993449.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', 'https://videos.pexels.com/video-files/4620563/4620563-sd_506_960_25fps.mp4', ARRAY['https://images.pexels.com/photos/3993449/pexels-photo-3993449.jpeg'], 599.99, 'USD', 789000, 'amazon', 'https://amazon.com/dp/B0BMBMTPSQ', 4.5, 12340, '11111111-1111-1111-1111-111111111102', ARRAY['다이슨', '헤어', '스타일러'], true, true, 4560),

('22222222-2222-2222-2222-222222222211', 'COSRX 스네일 뮤신 96% 파워 에센스', 'cosrx-snail-mucin', '달팽이 점액 96% 함유, 수분 공급과 피부 재생', 'https://images.pexels.com/photos/4465124/pexels-photo-4465124.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/4465124/pexels-photo-4465124.jpeg'], 21.99, 'USD', 28900, 'amazon', 'https://amazon.com/dp/B00PBX3L7K', 4.6, 89230, '11111111-1111-1111-1111-111111111102', ARRAY['코스알엑스', '에센스', '달팽이', 'K-뷰티'], false, true, 6780),

('22222222-2222-2222-2222-222222222212', 'Charlotte Tilbury 필로우 톡 립스틱', 'charlotte-tilbury-pillow-talk', '전세계 베스트셀러, 누드 핑크 립스틱', 'https://images.pexels.com/photos/2533266/pexels-photo-2533266.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/2533266/pexels-photo-2533266.jpeg'], 34.00, 'USD', 44900, 'amazon', 'https://amazon.com/dp/B07GVKFJ9B', 4.5, 34560, '11111111-1111-1111-1111-111111111102', ARRAY['샬롯틸버리', '립스틱', '메이크업'], false, true, 2340),

('22222222-2222-2222-2222-222222222213', 'Paula''s Choice 2% BHA 리퀴드', 'paulas-choice-bha', '살리실산 2% 함유, 모공 관리와 각질 제거', 'https://images.pexels.com/photos/5069432/pexels-photo-5069432.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/5069432/pexels-photo-5069432.jpeg'], 32.00, 'USD', 42000, 'amazon', 'https://amazon.com/dp/B00949CTQQ', 4.7, 67890, '11111111-1111-1111-1111-111111111102', ARRAY['폴라초이스', 'BHA', '각질', '모공'], false, true, 3450),

-- 패션 (6개)
('22222222-2222-2222-2222-222222222214', 'Levi''s 501 오리지널 핏 청바지', 'levis-501-original', '1873년부터 이어온 클래식, 스트레이트 핏 데님', 'https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg'], 69.50, 'USD', 89000, 'amazon', 'https://amazon.com/dp/B0007PB4LK', 4.5, 45670, '11111111-1111-1111-1111-111111111103', ARRAY['리바이스', '청바지', '데님', '클래식'], false, true, 1230),

('22222222-2222-2222-2222-222222222215', 'Nike Air Force 1 ''07', 'nike-air-force-1', '1982년부터 이어온 아이콘, 클래식 화이트 스니커즈', 'https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', 'https://videos.pexels.com/video-files/4620563/4620563-sd_506_960_25fps.mp4', ARRAY['https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg'], 115.00, 'USD', 139000, 'amazon', 'https://amazon.com/dp/B07RNQDZRX', 4.7, 78900, '11111111-1111-1111-1111-111111111103', ARRAY['나이키', '스니커즈', '에어포스', '클래식'], true, true, 5670),

('22222222-2222-2222-2222-222222222216', 'Ray-Ban 웨이페어러 클래식', 'rayban-wayfarer', '1956년 탄생한 아이코닉 선글라스', 'https://images.pexels.com/photos/701877/pexels-photo-701877.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/701877/pexels-photo-701877.jpeg'], 161.00, 'USD', 213000, 'amazon', 'https://amazon.com/dp/B001UQ71GY', 4.8, 23450, '11111111-1111-1111-1111-111111111103', ARRAY['레이밴', '선글라스', '웨이페어러'], false, true, 890),

('22222222-2222-2222-2222-222222222217', 'Uniqlo 울트라 라이트 다운 재킷', 'uniqlo-ultra-light-down', '초경량 프리미엄 다운, 휴대용 파우치 포함', 'https://images.pexels.com/photos/6764007/pexels-photo-6764007.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/6764007/pexels-photo-6764007.jpeg'], 79.90, 'USD', 99000, 'amazon', 'https://amazon.com/dp/B07YZQG3QH', 4.6, 12340, '11111111-1111-1111-1111-111111111103', ARRAY['유니클로', '패딩', '다운', '경량'], false, true, 2340),

('22222222-2222-2222-2222-222222222218', 'Fjallraven Kanken 백팩', 'fjallraven-kanken', '1978년 스웨덴에서 탄생한 클래식 백팩', 'https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg'], 80.00, 'USD', 105000, 'amazon', 'https://amazon.com/dp/B00B3CQWGG', 4.8, 34560, '11111111-1111-1111-1111-111111111103', ARRAY['피엘라벤', '백팩', '칸켄', '북유럽'], true, true, 3450),

('22222222-2222-2222-2222-222222222219', 'Adidas Ultraboost 22 러닝화', 'adidas-ultraboost-22', '부스트 미드솔, 프라임니트 어퍼의 프리미엄 러닝화', 'https://images.pexels.com/photos/2529147/pexels-photo-2529147.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/2529147/pexels-photo-2529147.jpeg'], 190.00, 'USD', 229000, 'amazon', 'https://amazon.com/dp/B09MDMGQWK', 4.6, 8920, '11111111-1111-1111-1111-111111111103', ARRAY['아디다스', '러닝화', '울트라부스트'], false, true, 1560),

-- 건강식품 (6개)
('22222222-2222-2222-2222-222222222220', 'Nature Made 비타민D3 5000IU', 'nature-made-vitamin-d3', '면역력 강화, 뼈 건강을 위한 고함량 비타민D', 'https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg'], 14.99, 'USD', 19800, 'iherb', 'https://iherb.com/pr/nature-made-vitamin-d3', 4.8, 45670, '11111111-1111-1111-1111-111111111104', ARRAY['비타민', '비타민D', '면역력', '뼈건강'], false, true, 4560),

('22222222-2222-2222-2222-222222222221', 'NOW Foods 오메가3 피쉬오일', 'now-omega3-fish-oil', 'EPA/DHA 1000mg, 심혈관 건강을 위한 필수 영양제', 'https://images.pexels.com/photos/3683051/pexels-photo-3683051.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/3683051/pexels-photo-3683051.jpeg'], 24.99, 'USD', 32900, 'iherb', 'https://iherb.com/pr/now-foods-omega-3', 4.7, 34560, '11111111-1111-1111-1111-111111111104', ARRAY['오메가3', '피쉬오일', '심혈관', 'EPA'], false, true, 3450),

('22222222-2222-2222-2222-222222222222', 'Optimum Nutrition 골드스탠다드 웨이', 'on-gold-standard-whey', '세계 1위 판매 프로틴, 순수 유청 단백질', 'https://images.pexels.com/photos/4397840/pexels-photo-4397840.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', 'https://videos.pexels.com/video-files/4620563/4620563-sd_506_960_25fps.mp4', ARRAY['https://images.pexels.com/photos/4397840/pexels-photo-4397840.jpeg'], 64.99, 'USD', 85000, 'iherb', 'https://iherb.com/pr/optimum-nutrition-gold-standard', 4.8, 89230, '11111111-1111-1111-1111-111111111104', ARRAY['프로틴', '웨이', '단백질', '근육'], true, true, 7890),

('22222222-2222-2222-2222-222222222223', 'Garden of Life 프로바이오틱스', 'garden-of-life-probiotics', '500억 CFU, 34종 유산균 복합 프로바이오틱스', 'https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg'], 39.99, 'USD', 52900, 'iherb', 'https://iherb.com/pr/garden-of-life-probiotics', 4.6, 23450, '11111111-1111-1111-1111-111111111104', ARRAY['유산균', '프로바이오틱스', '장건강'], false, true, 2340),

('22222222-2222-2222-2222-222222222224', 'Sports Research 콜라겐 펩타이드', 'sports-research-collagen', '가수분해 콜라겐 타입 I & III, 피부와 관절 건강', 'https://images.pexels.com/photos/5938242/pexels-photo-5938242.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/5938242/pexels-photo-5938242.jpeg'], 29.95, 'USD', 39500, 'iherb', 'https://iherb.com/pr/sports-research-collagen', 4.7, 56780, '11111111-1111-1111-1111-111111111104', ARRAY['콜라겐', '피부', '관절', '펩타이드'], true, true, 5670),

('22222222-2222-2222-2222-222222222225', 'California Gold Nutrition 비타민C', 'cgn-vitamin-c', '1000mg 비타민C, 면역력 강화와 항산화', 'https://images.pexels.com/photos/3683051/pexels-photo-3683051.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/3683051/pexels-photo-3683051.jpeg'], 8.00, 'USD', 10500, 'iherb', 'https://iherb.com/pr/cgn-vitamin-c', 4.8, 78900, '11111111-1111-1111-1111-111111111104', ARRAY['비타민C', '면역력', '항산화'], false, true, 6780);

-- 주방용품 (6개)
INSERT INTO public.products (id, title, slug, description, thumbnail_url, video_url, images, original_price, currency, price_krw, source_platform, source_url, external_rating, external_review_count, category_id, tags, is_featured, is_active, view_count) VALUES
('22222222-2222-2222-2222-222222222226', 'Le Creuset 시그니처 더치오븐 5.5qt', 'le-creuset-dutch-oven', '프랑스 장인이 만든 에나멜 주철 냄비, 평생 보증', 'https://images.pexels.com/photos/6996085/pexels-photo-6996085.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/6996085/pexels-photo-6996085.jpeg'], 399.95, 'USD', 529000, 'amazon', 'https://amazon.com/dp/B00005QFP1', 4.9, 12340, '11111111-1111-1111-1111-111111111105', ARRAY['르크루제', '더치오븐', '주철', '프랑스'], true, true, 2340),

('22222222-2222-2222-2222-222222222227', 'Vitamix E310 블렌더', 'vitamix-e310', '2.2마력 모터, 항공기급 스테인리스 블레이드', 'https://images.pexels.com/photos/1797104/pexels-photo-1797104.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', 'https://videos.pexels.com/video-files/4620563/4620563-sd_506_960_25fps.mp4', ARRAY['https://images.pexels.com/photos/1797104/pexels-photo-1797104.jpeg'], 349.95, 'USD', 459000, 'amazon', 'https://amazon.com/dp/B0758JHZM3', 4.8, 8920, '11111111-1111-1111-1111-111111111105', ARRAY['바이타믹스', '블렌더', '믹서기', '스무디'], true, true, 3450),

('22222222-2222-2222-2222-222222222228', 'KitchenAid 스탠드 믹서 5qt', 'kitchenaid-stand-mixer', '10단계 속도 조절, 59가지 어태치먼트 호환', 'https://images.pexels.com/photos/4226870/pexels-photo-4226870.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/4226870/pexels-photo-4226870.jpeg'], 379.99, 'USD', 499000, 'amazon', 'https://amazon.com/dp/B00005UP2K', 4.8, 45670, '11111111-1111-1111-1111-111111111105', ARRAY['키친에이드', '믹서', '베이킹', '스탠드믹서'], false, true, 4560),

('22222222-2222-2222-2222-222222222229', 'Instant Pot Duo 7-in-1 6qt', 'instant-pot-duo', '7가지 기능을 하나로, 전기 압력밥솥의 혁신', 'https://images.pexels.com/photos/6996085/pexels-photo-6996085.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/6996085/pexels-photo-6996085.jpeg'], 89.95, 'USD', 118000, 'amazon', 'https://amazon.com/dp/B00FLYWNYQ', 4.7, 234560, '11111111-1111-1111-1111-111111111105', ARRAY['인스턴트팟', '압력밥솥', '멀티쿠커'], false, true, 8900),

('22222222-2222-2222-2222-222222222230', 'Zwilling J.A. Henckels 나이프 세트', 'zwilling-knife-set', '독일 장인 정신, 아이스 하드닝 블레이드', 'https://images.pexels.com/photos/4226805/pexels-photo-4226805.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/4226805/pexels-photo-4226805.jpeg'], 199.99, 'USD', 263000, 'amazon', 'https://amazon.com/dp/B00004RFMT', 4.8, 12340, '11111111-1111-1111-1111-111111111105', ARRAY['쌍칼', '나이프', '칼세트', '독일'], false, true, 1230),

('22222222-2222-2222-2222-222222222231', 'Ninja Foodi 에어프라이어 6qt', 'ninja-foodi-air-fryer', '4-in-1 에어프라이, 로스트, 리히트, 디하이드레이트', 'https://images.pexels.com/photos/6996085/pexels-photo-6996085.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/6996085/pexels-photo-6996085.jpeg'], 119.99, 'USD', 158000, 'amazon', 'https://amazon.com/dp/B07S6529ZZ', 4.7, 56780, '11111111-1111-1111-1111-111111111105', ARRAY['닌자', '에어프라이어', '튀김기'], false, true, 5670),

-- 스포츠 (6개)
('22222222-2222-2222-2222-222222222232', 'Theragun Pro 마사지건', 'theragun-pro', '16mm 진폭, 60lbs 힘, 프로 선수급 근육 케어', 'https://images.pexels.com/photos/4498362/pexels-photo-4498362.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', 'https://videos.pexels.com/video-files/4620563/4620563-sd_506_960_25fps.mp4', ARRAY['https://images.pexels.com/photos/4498362/pexels-photo-4498362.jpeg'], 599.00, 'USD', 789000, 'amazon', 'https://amazon.com/dp/B087MK6GLK', 4.7, 8920, '11111111-1111-1111-1111-111111111106', ARRAY['테라건', '마사지건', '근육', '회복'], true, true, 3450),

('22222222-2222-2222-2222-222222222233', 'Garmin Forerunner 265 GPS 워치', 'garmin-forerunner-265', 'AMOLED 디스플레이, 고급 러닝 다이내믹스', 'https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg'], 449.99, 'USD', 589000, 'amazon', 'https://amazon.com/dp/B0BS1N8JH1', 4.8, 5670, '11111111-1111-1111-1111-111111111106', ARRAY['가민', 'GPS', '러닝워치', '스마트워치'], true, true, 2340),

('22222222-2222-2222-2222-222222222234', 'Bowflex SelectTech 552 덤벨', 'bowflex-selecttech-552', '5~52.5lbs 15단계 무게 조절, 공간 절약형', 'https://images.pexels.com/photos/4162487/pexels-photo-4162487.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/4162487/pexels-photo-4162487.jpeg'], 429.00, 'USD', 565000, 'amazon', 'https://amazon.com/dp/B001ARYU58', 4.8, 34560, '11111111-1111-1111-1111-111111111106', ARRAY['보우플렉스', '덤벨', '홈트', '웨이트'], false, true, 4560),

('22222222-2222-2222-2222-222222222235', 'Manduka PRO 요가 매트 6mm', 'manduka-pro-yoga-mat', '평생 보증, 고밀도 쿠션, 미끄럼 방지', 'https://images.pexels.com/photos/4056535/pexels-photo-4056535.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/4056535/pexels-photo-4056535.jpeg'], 120.00, 'USD', 158000, 'amazon', 'https://amazon.com/dp/B0002TSKPO', 4.8, 23450, '11111111-1111-1111-1111-111111111106', ARRAY['만두카', '요가매트', '요가', '필라테스'], false, true, 1890),

('22222222-2222-2222-2222-222222222236', 'Hydro Flask 32oz 보온병', 'hydro-flask-32oz', 'TempShield 단열, 24시간 보냉/12시간 보온', 'https://images.pexels.com/photos/4498362/pexels-photo-4498362.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/4498362/pexels-photo-4498362.jpeg'], 44.95, 'USD', 59000, 'amazon', 'https://amazon.com/dp/B01ACAXP7S', 4.8, 67890, '11111111-1111-1111-1111-111111111106', ARRAY['하이드로플라스크', '보온병', '텀블러', '물병'], false, true, 5670),

('22222222-2222-2222-2222-222222222237', 'Peloton 바이크 매트', 'peloton-bike-mat', '고밀도 폼, 바닥 보호 및 소음 감소', 'https://images.pexels.com/photos/4056535/pexels-photo-4056535.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/4056535/pexels-photo-4056535.jpeg'], 59.00, 'USD', 78000, 'amazon', 'https://amazon.com/dp/B08CXNHXWJ', 4.6, 8920, '11111111-1111-1111-1111-111111111106', ARRAY['펠로톤', '매트', '실내자전거', '홈트'], false, true, 890),

-- 유아용품 (6개)
('22222222-2222-2222-2222-222222222238', 'UPPAbaby Vista V2 유모차', 'uppababy-vista-v2', '풀사이즈 유모차, 확장 가능한 시스템', 'https://images.pexels.com/photos/3933025/pexels-photo-3933025.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', 'https://videos.pexels.com/video-files/4620563/4620563-sd_506_960_25fps.mp4', ARRAY['https://images.pexels.com/photos/3933025/pexels-photo-3933025.jpeg'], 969.99, 'USD', 1279000, 'amazon', 'https://amazon.com/dp/B084GQNM3D', 4.8, 5670, '11111111-1111-1111-1111-111111111107', ARRAY['어파베이비', '유모차', '비스타', '프리미엄'], true, true, 3450),

('22222222-2222-2222-2222-222222222239', 'Ergobaby Omni 360 아기띠', 'ergobaby-omni-360', '신생아부터 48개월까지, 4가지 착용 방법', 'https://images.pexels.com/photos/3933025/pexels-photo-3933025.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/3933025/pexels-photo-3933025.jpeg'], 180.00, 'USD', 237000, 'amazon', 'https://amazon.com/dp/B0721B3WQV', 4.7, 23450, '11111111-1111-1111-1111-111111111107', ARRAY['에르고베이비', '아기띠', '캐리어', '신생아'], true, true, 2340),

('22222222-2222-2222-2222-222222222240', 'LEGO 클래식 라지 크리에이티브 브릭 박스', 'lego-classic-large', '790개 피스, 무한한 창의력을 위한 세트', 'https://images.pexels.com/photos/298825/pexels-photo-298825.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/298825/pexels-photo-298825.jpeg'], 49.99, 'USD', 65900, 'amazon', 'https://amazon.com/dp/B00NHQF6MG', 4.9, 89230, '11111111-1111-1111-1111-111111111107', ARRAY['레고', '블록', '창의력', '장난감'], false, true, 6780),

('22222222-2222-2222-2222-222222222241', 'Hatch Rest+ 수면등 & 백색소음기', 'hatch-rest-plus', '시계, 수면등, 백색소음기, 알람 올인원', 'https://images.pexels.com/photos/3933025/pexels-photo-3933025.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/3933025/pexels-photo-3933025.jpeg'], 89.99, 'USD', 118000, 'amazon', 'https://amazon.com/dp/B08SLPYV8M', 4.7, 12340, '11111111-1111-1111-1111-111111111107', ARRAY['해치', '수면등', '백색소음', '아기수면'], false, true, 1890),

('22222222-2222-2222-2222-222222222242', 'Graco 4Ever DLX 카시트', 'graco-4ever-dlx', '10년 사용 가능, 4-in-1 컨버터블 카시트', 'https://images.pexels.com/photos/3933025/pexels-photo-3933025.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/3933025/pexels-photo-3933025.jpeg'], 299.99, 'USD', 395000, 'amazon', 'https://amazon.com/dp/B07J2WMCT5', 4.8, 34560, '11111111-1111-1111-1111-111111111107', ARRAY['그라코', '카시트', '안전', '유아'], false, true, 4560),

('22222222-2222-2222-2222-222222222243', 'Skip Hop 아기 활동 센터', 'skip-hop-activity-center', '3단계 성장형, 360도 회전 시트', 'https://images.pexels.com/photos/298825/pexels-photo-298825.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/298825/pexels-photo-298825.jpeg'], 159.99, 'USD', 211000, 'amazon', 'https://amazon.com/dp/B07CNRHW3K', 4.6, 8920, '11111111-1111-1111-1111-111111111107', ARRAY['스킵합', '활동센터', '장난감', '발달'], false, true, 1230),

-- 홈인테리어 (7개)
('22222222-2222-2222-2222-222222222244', 'Philips Hue 스타터 키트', 'philips-hue-starter-kit', '스마트 조명 시스템, 1600만 컬러', 'https://images.pexels.com/photos/1123262/pexels-photo-1123262.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', 'https://videos.pexels.com/video-files/4620563/4620563-sd_506_960_25fps.mp4', ARRAY['https://images.pexels.com/photos/1123262/pexels-photo-1123262.jpeg'], 199.99, 'USD', 263000, 'amazon', 'https://amazon.com/dp/B07QV9XB87', 4.7, 23450, '11111111-1111-1111-1111-111111111108', ARRAY['필립스', '휴', '스마트조명', 'IoT'], true, true, 4560),

('22222222-2222-2222-2222-222222222245', 'Dyson Pure Cool 공기청정기', 'dyson-pure-cool', 'HEPA 필터, 350도 회전, 앱 연동', 'https://images.pexels.com/photos/1123262/pexels-photo-1123262.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/1123262/pexels-photo-1123262.jpeg'], 549.99, 'USD', 725000, 'amazon', 'https://amazon.com/dp/B07NX5QBQD', 4.6, 12340, '11111111-1111-1111-1111-111111111108', ARRAY['다이슨', '공기청정기', 'HEPA', '선풍기'], true, true, 3450),

('22222222-2222-2222-2222-222222222246', 'iRobot Roomba j7+ 로봇청소기', 'irobot-roomba-j7', '장애물 인식, 자동 먼지 비움, 스마트 매핑', 'https://images.pexels.com/photos/4107278/pexels-photo-4107278.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/4107278/pexels-photo-4107278.jpeg'], 799.00, 'USD', 1049000, 'amazon', 'https://amazon.com/dp/B094NYHTMF', 4.5, 8920, '11111111-1111-1111-1111-111111111108', ARRAY['아이로봇', '룸바', '로봇청소기', '스마트홈'], false, true, 5670),

('22222222-2222-2222-2222-222222222247', 'Casper 오리지널 매트리스 퀸', 'casper-original-mattress', '4층 폼 구조, 100일 무료 체험', 'https://images.pexels.com/photos/1034584/pexels-photo-1034584.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/1034584/pexels-photo-1034584.jpeg'], 1095.00, 'USD', 1445000, 'amazon', 'https://amazon.com/dp/B079NQMFZK', 4.6, 15670, '11111111-1111-1111-1111-111111111108', ARRAY['캐스퍼', '매트리스', '침대', '수면'], false, true, 2340),

('22222222-2222-2222-2222-222222222248', 'Nest Learning Thermostat', 'nest-learning-thermostat', '자동 학습, 에너지 절약, 원격 제어', 'https://images.pexels.com/photos/1123262/pexels-photo-1123262.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/1123262/pexels-photo-1123262.jpeg'], 249.00, 'USD', 329000, 'amazon', 'https://amazon.com/dp/B0131RG6VK', 4.7, 34560, '11111111-1111-1111-1111-111111111108', ARRAY['네스트', '온도조절기', '스마트홈', '에너지'], false, true, 1890),

('22222222-2222-2222-2222-222222222249', 'Sonos One SL 스피커', 'sonos-one-sl', '풍부한 사운드, 멀티룸 오디오, AirPlay 2', 'https://images.pexels.com/photos/1123262/pexels-photo-1123262.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/1123262/pexels-photo-1123262.jpeg'], 199.00, 'USD', 263000, 'amazon', 'https://amazon.com/dp/B07W8ZVXWR', 4.8, 12340, '11111111-1111-1111-1111-111111111108', ARRAY['소노스', '스피커', '오디오', '멀티룸'], false, true, 3450),

('22222222-2222-2222-2222-222222222250', 'West Elm 미드센추리 책상', 'west-elm-mid-century-desk', '아카시아 원목, 미드센추리 모던 디자인', 'https://images.pexels.com/photos/1034584/pexels-photo-1034584.jpeg?auto=compress&cs=tinysrgb&w=600&h=1067&dpr=1', NULL, ARRAY['https://images.pexels.com/photos/1034584/pexels-photo-1034584.jpeg'], 599.00, 'USD', 789000, 'amazon', 'https://amazon.com/dp/B08DXZNHKF', 4.5, 5670, '11111111-1111-1111-1111-111111111108', ARRAY['웨스트엘름', '책상', '가구', '미드센추리'], false, true, 1560);

-- ============================================
-- 3. 외부 리뷰 (100개 - 상품당 2개씩)
-- ============================================

INSERT INTO public.external_reviews (product_id, content, translated_content, reviewer_name, reviewer_country, rating, source_language, source_platform, helpful_count, is_verified_purchase, is_translated) VALUES
-- AirPods Pro 2
('22222222-2222-2222-2222-222222222201', 'The noise cancellation is incredible! Best earbuds I have ever owned. Battery life is amazing and the sound quality is top notch.', '노이즈 캔슬링이 정말 놀라워요! 지금까지 사용한 이어버드 중 최고입니다. 배터리 수명도 훌륭하고 음질도 최상급이에요.', 'John M.', 'US', 5.0, 'en', 'amazon', 234, true, true),
('22222222-2222-2222-2222-222222222201', 'Great upgrade from the original AirPods Pro. The adaptive audio feature is a game changer for commuting.', '오리지널 에어팟 프로에서 훌륭한 업그레이드입니다. 적응형 오디오 기능은 출퇴근할 때 정말 획기적이에요.', 'Sarah K.', 'UK', 4.5, 'en', 'amazon', 156, true, true),

-- Galaxy Buds2 Pro
('22222222-2222-2222-2222-222222222202', 'Perfect fit and amazing sound. The 360 Audio feature makes movies feel immersive.', '완벽한 착용감과 놀라운 사운드. 360 오디오 기능으로 영화가 몰입감 있게 느껴져요.', 'Mike T.', 'US', 4.5, 'en', 'amazon', 89, true, true),
('22222222-2222-2222-2222-222222222202', 'Good earbuds but ANC could be stronger. Great for Samsung phone users.', '좋은 이어버드지만 ANC가 더 강했으면 좋겠어요. 삼성폰 사용자에게 좋습니다.', 'Emily R.', 'CA', 4.0, 'en', 'amazon', 67, true, true),

-- Apple Watch Series 9
('22222222-2222-2222-2222-222222222203', 'The double tap gesture is so convenient! Health tracking features are comprehensive and accurate.', '더블 탭 제스처가 정말 편리해요! 건강 추적 기능이 포괄적이고 정확합니다.', 'David L.', 'US', 5.0, 'en', 'amazon', 312, true, true),
('22222222-2222-2222-2222-222222222203', 'Best smartwatch on the market. The bright display is perfect for outdoor use.', '시장에서 최고의 스마트워치입니다. 밝은 디스플레이가 야외 사용에 완벽해요.', 'Lisa M.', 'AU', 4.5, 'en', 'amazon', 198, true, true),

-- Sony WH-1000XM5
('22222222-2222-2222-2222-222222222204', 'Industry leading noise cancellation. The 30 hour battery life is incredible for long flights.', '업계 최고의 노이즈 캔슬링. 30시간 배터리 수명은 장거리 비행에 정말 좋아요.', 'James W.', 'US', 5.0, 'en', 'amazon', 456, true, true),
('22222222-2222-2222-2222-222222222204', 'Comfortable for all day wear. Sound quality is exceptional with LDAC codec.', '하루 종일 착용해도 편안해요. LDAC 코덱으로 음질이 뛰어납니다.', 'Anna S.', 'DE', 4.5, 'de', 'amazon', 234, true, true),

-- Anker 737 Power Bank
('22222222-2222-2222-2222-222222222205', 'This thing is a beast! Charges my MacBook Pro multiple times. The display is very useful.', '이건 정말 괴물이에요! 맥북 프로를 여러 번 충전할 수 있어요. 디스플레이가 매우 유용합니다.', 'Chris P.', 'US', 5.0, 'en', 'amazon', 178, true, true),
('22222222-2222-2222-2222-222222222205', 'Heavy but worth it for the capacity. 140W charging is incredibly fast.', '무겁지만 용량을 생각하면 가치가 있어요. 140W 충전이 엄청 빠릅니다.', 'Tom H.', 'UK', 4.0, 'en', 'amazon', 89, true, true),

-- Logitech MX Master 3S
('22222222-2222-2222-2222-222222222206', 'The quietest mouse I have ever used. Perfect for office environments. Scroll wheel is amazing.', '지금까지 사용한 마우스 중 가장 조용해요. 사무실 환경에 완벽합니다. 스크롤 휠이 놀라워요.', 'Rachel K.', 'US', 5.0, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222206', 'Great ergonomics and the multi-device switching is seamless. Worth every penny.', '인체공학적으로 훌륭하고 멀티 디바이스 전환이 매끄럽습니다. 모든 가치가 있어요.', 'Steve M.', 'CA', 4.5, 'en', 'amazon', 234, true, true),

-- iPad Pro 11
('22222222-2222-2222-2222-222222222207', 'M4 chip is insanely powerful. This is basically a laptop replacement for me now.', 'M4 칩이 미친 듯이 강력해요. 이제 기본적으로 노트북 대체품이 되었어요.', 'Kevin L.', 'US', 5.0, 'en', 'amazon', 567, true, true),
('22222222-2222-2222-2222-222222222207', 'The display is stunning. Apple Pencil Pro integration is perfect for artists.', '디스플레이가 정말 멋져요. 애플 펜슬 프로 통합이 아티스트에게 완벽합니다.', 'Amy C.', 'UK', 5.0, 'en', 'amazon', 432, true, true),

-- La Mer Cream
('22222222-2222-2222-2222-222222222208', 'Expensive but worth it. My skin has never looked better. The texture is luxurious.', '비싸지만 가치가 있어요. 피부가 이렇게 좋아 보인 적이 없어요. 텍스처가 럭셔리해요.', 'Jennifer H.', 'US', 5.0, 'en', 'amazon', 234, true, true),
('22222222-2222-2222-2222-222222222208', 'A little goes a long way. Been using for 3 months and see visible improvements.', '조금만 써도 오래 가요. 3개월 사용 중인데 눈에 띄는 개선이 보여요.', 'Michelle L.', 'SG', 4.5, 'en', 'amazon', 178, true, true),

-- SK-II Essence
('22222222-2222-2222-2222-222222222209', 'Holy grail product! My skin is so much brighter and smoother after using this.', '성배 제품이에요! 이거 사용 후 피부가 훨씬 밝고 매끄러워졌어요.', 'Diana W.', 'US', 5.0, 'en', 'amazon', 456, true, true),
('22222222-2222-2222-2222-222222222209', 'ピテラの効果は本物です。肌の調子が良くなりました。', '피테라의 효과는 진짜예요. 피부 상태가 좋아졌어요.', 'Yuki T.', 'JP', 4.5, 'ja', 'amazon', 234, true, true),

-- Dyson Airwrap
('22222222-2222-2222-2222-222222222210', 'Game changer for styling! No heat damage and the curls last all day.', '스타일링의 게임 체인저! 열 손상 없이 컬이 하루 종일 유지돼요.', 'Sophia R.', 'US', 5.0, 'en', 'amazon', 567, true, true),
('22222222-2222-2222-2222-222222222210', 'Expensive but the results are salon quality. Learning curve but worth it.', '비싸지만 결과는 살롱 퀄리티예요. 배우는 데 시간이 걸리지만 가치가 있어요.', 'Emma B.', 'UK', 4.0, 'en', 'amazon', 345, true, true),

-- COSRX Snail Mucin
('22222222-2222-2222-2222-222222222211', 'Best affordable skincare product! My skin is so hydrated and plump.', '가장 좋은 가성비 스킨케어 제품! 피부가 정말 촉촉하고 탱탱해졌어요.', 'Nicole P.', 'US', 5.0, 'en', 'amazon', 789, true, true),
('22222222-2222-2222-2222-222222222211', 'K-beauty at its finest. Works great under makeup and absorbs quickly.', 'K-뷰티의 정수예요. 메이크업 아래에서 잘 작동하고 빠르게 흡수돼요.', 'Grace L.', 'AU', 4.5, 'en', 'amazon', 456, true, true),

-- Charlotte Tilbury Lipstick
('22222222-2222-2222-2222-222222222212', 'The perfect nude pink! Looks good on everyone. Moisturizing formula.', '완벽한 누드 핑크! 누구에게나 잘 어울려요. 보습 포뮬라예요.', 'Victoria S.', 'US', 5.0, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222212', 'My everyday lipstick. The packaging is beautiful and it lasts for hours.', '제 매일 립스틱이에요. 패키지가 아름답고 몇 시간 동안 지속돼요.', 'Olivia M.', 'UK', 4.5, 'en', 'amazon', 234, true, true),

-- Paula's Choice BHA
('22222222-2222-2222-2222-222222222213', 'Cleared my acne in weeks! Gentle but effective. A must have for oily skin.', '몇 주 만에 여드름이 사라졌어요! 순하지만 효과적이에요. 지성 피부 필수품이에요.', 'Ashley T.', 'US', 5.0, 'en', 'amazon', 678, true, true),
('22222222-2222-2222-2222-222222222213', 'Best exfoliant I have tried. Pores are visibly smaller after a month.', '제가 시도한 최고의 각질제거제예요. 한 달 후 모공이 눈에 띄게 작아졌어요.', 'Hannah J.', 'CA', 4.5, 'en', 'amazon', 456, true, true),

-- Levi's 501
('22222222-2222-2222-2222-222222222214', 'Classic fit that never goes out of style. Quality denim that lasts years.', '절대 유행을 타지 않는 클래식 핏. 몇 년 동안 지속되는 품질 좋은 데님이에요.', 'Robert J.', 'US', 4.5, 'en', 'amazon', 234, true, true),
('22222222-2222-2222-2222-222222222214', 'True to size. The rigid denim breaks in perfectly over time.', '사이즈가 정확해요. 리지드 데님이 시간이 지나면서 완벽하게 길들여져요.', 'Daniel K.', 'UK', 4.0, 'en', 'amazon', 178, true, true),

-- Nike Air Force 1
('22222222-2222-2222-2222-222222222215', 'Timeless classic! Goes with everything. Comfortable right out of the box.', '시대를 초월한 클래식! 모든 것과 어울려요. 박스에서 꺼내자마자 편안해요.', 'Marcus T.', 'US', 5.0, 'en', 'amazon', 567, true, true),
('22222222-2222-2222-2222-222222222215', 'Best white sneakers ever. Easy to clean and very durable.', '최고의 화이트 스니커즈. 청소하기 쉽고 매우 내구성이 좋아요.', 'Brandon L.', 'CA', 4.5, 'en', 'amazon', 345, true, true),

-- Ray-Ban Wayfarer
('22222222-2222-2222-2222-222222222216', 'Iconic sunglasses that look good on any face shape. Quality is excellent.', '어떤 얼굴형에도 잘 어울리는 아이코닉 선글라스. 품질이 훌륭해요.', 'Andrew M.', 'US', 5.0, 'en', 'amazon', 234, true, true),
('22222222-2222-2222-2222-222222222216', 'Worth the investment. The polarized lenses make a huge difference.', '투자할 가치가 있어요. 편광 렌즈가 큰 차이를 만들어요.', 'Jason R.', 'AU', 4.5, 'en', 'amazon', 178, true, true),

-- Uniqlo Ultra Light Down
('22222222-2222-2222-2222-222222222217', 'Perfect for layering. So light you forget you are wearing it. Packs down small.', '레이어링에 완벽해요. 너무 가벼워서 입고 있는 걸 잊어버려요. 작게 접혀요.', 'Peter H.', 'US', 4.5, 'en', 'amazon', 234, true, true),
('22222222-2222-2222-2222-222222222217', 'Great value for money. Keeps me warm in mild winter weather.', '가성비가 좋아요. 온화한 겨울 날씨에 따뜻하게 해줘요.', 'Simon W.', 'UK', 4.0, 'en', 'amazon', 156, true, true),

-- Fjallraven Kanken
('22222222-2222-2222-2222-222222222218', 'Love this backpack! Durable and stylish. Perfect size for daily use.', '이 백팩 정말 좋아요! 튼튼하고 스타일리시해요. 일상용으로 완벽한 사이즈예요.', 'Emma S.', 'US', 5.0, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222218', 'Classic Scandinavian design. Water resistant and easy to clean.', '클래식한 스칸디나비안 디자인. 방수되고 청소하기 쉬워요.', 'Lena K.', 'SE', 4.5, 'en', 'amazon', 234, true, true),

-- Adidas Ultraboost 22
('22222222-2222-2222-2222-222222222219', 'Most comfortable running shoes I have owned. The boost cushioning is incredible.', '제가 가진 러닝화 중 가장 편해요. 부스트 쿠셔닝이 놀라워요.', 'Ryan P.', 'US', 4.5, 'en', 'amazon', 234, true, true),
('22222222-2222-2222-2222-222222222219', 'Great for long runs. Responsive and supportive. True to size.', '장거리 달리기에 좋아요. 반응성이 좋고 지지력이 있어요. 사이즈가 정확해요.', 'Alex M.', 'UK', 4.0, 'en', 'amazon', 178, true, true),

-- Nature Made Vitamin D3
('22222222-2222-2222-2222-222222222220', 'Great quality vitamin D. Easy to swallow and no aftertaste.', '훌륭한 품질의 비타민 D. 삼키기 쉽고 뒷맛이 없어요.', 'Linda C.', 'US', 5.0, 'en', 'iherb', 456, true, true),
('22222222-2222-2222-2222-222222222220', 'My doctor recommended this brand. Noticed improvement in energy levels.', '의사가 이 브랜드를 추천했어요. 에너지 수준이 개선된 걸 느꼈어요.', 'Carol T.', 'CA', 4.5, 'en', 'iherb', 234, true, true),

-- NOW Foods Omega 3
('22222222-2222-2222-2222-222222222221', 'No fishy burps! High quality fish oil at a great price.', '비린내 트림이 없어요! 좋은 가격에 고품질 피쉬오일이에요.', 'Mark D.', 'US', 4.5, 'en', 'iherb', 345, true, true),
('22222222-2222-2222-2222-222222222221', 'Been taking for years. Helps with joint health and inflammation.', '몇 년째 복용 중이에요. 관절 건강과 염증에 도움이 돼요.', 'Susan B.', 'UK', 4.0, 'en', 'iherb', 234, true, true),

-- Optimum Nutrition Whey
('22222222-2222-2222-2222-222222222222', 'Best tasting protein powder! Mixes easily and no clumps.', '가장 맛있는 프로틴 파우더! 쉽게 섞이고 덩어리가 없어요.', 'Jake F.', 'US', 5.0, 'en', 'iherb', 678, true, true),
('22222222-2222-2222-2222-222222222222', 'Gold standard for a reason. Great macros and tastes good.', '이유가 있어서 골드 스탠다드예요. 훌륭한 영양성분과 맛이에요.', 'Tyler G.', 'AU', 4.5, 'en', 'iherb', 456, true, true),

-- Garden of Life Probiotics
('22222222-2222-2222-2222-222222222223', 'Really helped with my digestive issues. Noticed difference in a week.', '소화 문제에 정말 도움이 됐어요. 일주일 만에 차이를 느꼈어요.', 'Nancy H.', 'US', 4.5, 'en', 'iherb', 345, true, true),
('22222222-2222-2222-2222-222222222223', 'High quality probiotics. Shelf stable which is convenient for travel.', '고품질 프로바이오틱스. 상온 보관 가능해서 여행에 편리해요.', 'Karen J.', 'CA', 4.0, 'en', 'iherb', 234, true, true),

-- Sports Research Collagen
('22222222-2222-2222-2222-222222222224', 'My skin and nails have improved so much! Dissolves completely in coffee.', '피부와 손톱이 정말 많이 좋아졌어요! 커피에 완전히 녹아요.', 'Megan L.', 'US', 5.0, 'en', 'iherb', 567, true, true),
('22222222-2222-2222-2222-222222222224', 'Great for joint health. No taste when mixed with drinks.', '관절 건강에 좋아요. 음료에 섞으면 맛이 없어요.', 'Jessica M.', 'UK', 4.5, 'en', 'iherb', 345, true, true),

-- California Gold Nutrition Vitamin C
('22222222-2222-2222-2222-222222222225', 'Best value vitamin C on the market. High quality and affordable.', '시장에서 가장 가성비 좋은 비타민 C. 고품질이고 저렴해요.', 'Paul N.', 'US', 5.0, 'en', 'iherb', 456, true, true),
('22222222-2222-2222-2222-222222222225', 'Take daily for immune support. Easy to swallow capsules.', '면역 지원을 위해 매일 복용해요. 삼키기 쉬운 캡슐이에요.', 'Mary O.', 'CA', 4.5, 'en', 'iherb', 234, true, true),

-- Le Creuset Dutch Oven
('22222222-2222-2222-2222-222222222226', 'Worth every penny! Makes the best stews and bread. Will last a lifetime.', '모든 돈의 가치가 있어요! 최고의 스튜와 빵을 만들어요. 평생 쓸 수 있어요.', 'Julia C.', 'US', 5.0, 'en', 'amazon', 456, true, true),
('22222222-2222-2222-2222-222222222226', 'Beautiful and functional. Even heat distribution is perfect.', '아름답고 기능적이에요. 균일한 열 분배가 완벽해요.', 'Ina G.', 'US', 5.0, 'en', 'amazon', 345, true, true),

-- Vitamix E310
('22222222-2222-2222-2222-222222222227', 'Makes the smoothest smoothies ever! Also great for soups and nut butters.', '가장 부드러운 스무디를 만들어요! 수프와 너트 버터에도 좋아요.', 'Chef B.', 'US', 5.0, 'en', 'amazon', 567, true, true),
('22222222-2222-2222-2222-222222222227', 'Powerful motor handles anything. Loud but worth it for the results.', '강력한 모터가 모든 것을 처리해요. 시끄럽지만 결과를 위해 가치가 있어요.', 'Gordon R.', 'UK', 4.5, 'en', 'amazon', 345, true, true),

-- KitchenAid Stand Mixer
('22222222-2222-2222-2222-222222222228', 'A baking essential! So many attachments available. Built to last.', '베이킹 필수품! 많은 어태치먼트를 사용할 수 있어요. 오래 쓸 수 있게 만들어졌어요.', 'Martha S.', 'US', 5.0, 'en', 'amazon', 678, true, true),
('22222222-2222-2222-2222-222222222228', 'Makes bread making so easy. The dough hook is amazing.', '빵 만들기가 정말 쉬워졌어요. 반죽 훅이 놀라워요.', 'Paul H.', 'UK', 4.5, 'en', 'amazon', 456, true, true),

-- Instant Pot Duo
('22222222-2222-2222-2222-222222222229', 'Changed my meal prep game! So many functions in one appliance.', '식사 준비가 완전히 바뀌었어요! 하나의 기기에 많은 기능이 있어요.', 'Busy M.', 'US', 5.0, 'en', 'amazon', 789, true, true),
('22222222-2222-2222-2222-222222222229', 'Perfect for busy weeknights. Pressure cooking cuts time in half.', '바쁜 평일 저녁에 완벽해요. 압력 요리가 시간을 절반으로 줄여요.', 'Working P.', 'CA', 4.5, 'en', 'amazon', 567, true, true),

-- Zwilling Knife Set
('22222222-2222-2222-2222-222222222230', 'German engineering at its finest. These knives stay sharp forever.', '독일 엔지니어링의 정수. 이 칼들은 영원히 날카로워요.', 'Anthony B.', 'US', 5.0, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222230', 'Professional quality knives. Well balanced and comfortable to use.', '프로페셔널 품질의 칼. 균형이 잘 잡혀 있고 사용하기 편해요.', 'Jamie O.', 'UK', 4.5, 'en', 'amazon', 234, true, true),

-- Ninja Foodi Air Fryer
('22222222-2222-2222-2222-222222222231', 'Best air fryer I have owned. Crispy results every time. Easy to clean.', '제가 가진 최고의 에어프라이어. 매번 바삭한 결과. 청소하기 쉬워요.', 'Home C.', 'US', 4.5, 'en', 'amazon', 456, true, true),
('22222222-2222-2222-2222-222222222231', 'Great capacity and versatile. The dehydrate function is a bonus.', '용량이 크고 다용도예요. 건조 기능은 보너스예요.', 'Kitchen L.', 'AU', 4.0, 'en', 'amazon', 234, true, true),

-- Theragun Pro
('22222222-2222-2222-2222-222222222232', 'Professional grade massage gun. Really helps with muscle recovery after workouts.', '프로페셔널급 마사지건. 운동 후 근육 회복에 정말 도움이 돼요.', 'Athlete J.', 'US', 5.0, 'en', 'amazon', 456, true, true),
('22222222-2222-2222-2222-222222222232', 'Expensive but worth it for serious athletes. Multiple attachments are useful.', '비싸지만 진지한 운동선수에게는 가치가 있어요. 여러 어태치먼트가 유용해요.', 'Trainer M.', 'UK', 4.5, 'en', 'amazon', 345, true, true),

-- Garmin Forerunner 265
('22222222-2222-2222-2222-222222222233', 'Best running watch on the market. GPS accuracy is incredible.', '시장에서 최고의 러닝 워치. GPS 정확도가 놀라워요.', 'Runner K.', 'US', 5.0, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222233', 'AMOLED display is beautiful. Training metrics are comprehensive.', 'AMOLED 디스플레이가 아름다워요. 훈련 지표가 포괄적이에요.', 'Marathon L.', 'DE', 4.5, 'en', 'amazon', 234, true, true),

-- Bowflex SelectTech 552
('22222222-2222-2222-2222-222222222234', 'Space saver! Replaces 15 pairs of dumbbells. Quick weight changes.', '공간 절약! 15쌍의 덤벨을 대체해요. 빠른 무게 변경.', 'Home G.', 'US', 5.0, 'en', 'amazon', 456, true, true),
('22222222-2222-2222-2222-222222222234', 'Perfect for home gym. Build quality is excellent.', '홈짐에 완벽해요. 빌드 품질이 훌륭해요.', 'Fitness F.', 'CA', 4.5, 'en', 'amazon', 345, true, true),

-- Manduka PRO Yoga Mat
('22222222-2222-2222-2222-222222222235', 'The last yoga mat you will ever need. Dense cushioning and great grip.', '마지막으로 필요할 요가 매트. 밀도 높은 쿠션과 훌륭한 그립.', 'Yogi A.', 'US', 5.0, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222235', 'Lifetime guarantee is real. Had mine for 5 years still like new.', '평생 보증이 진짜예요. 5년 동안 사용했는데 여전히 새것 같아요.', 'Zen M.', 'AU', 4.5, 'en', 'amazon', 234, true, true),

-- Hydro Flask 32oz
('22222222-2222-2222-2222-222222222236', 'Keeps water cold for 24 hours! No condensation on the outside.', '물을 24시간 동안 차갑게 유지해요! 외부에 결로가 없어요.', 'Hiker T.', 'US', 5.0, 'en', 'amazon', 456, true, true),
('22222222-2222-2222-2222-222222222236', 'Durable and leak proof. The powder coat finish is nice.', '튼튼하고 새지 않아요. 파우더 코트 마감이 좋아요.', 'Outdoor E.', 'CA', 4.5, 'en', 'amazon', 345, true, true),

-- Peloton Bike Mat
('22222222-2222-2222-2222-222222222237', 'Protects my hardwood floors. Reduces noise significantly.', '원목 바닥을 보호해요. 소음을 상당히 줄여줘요.', 'Cyclist P.', 'US', 4.5, 'en', 'amazon', 234, true, true),
('22222222-2222-2222-2222-222222222237', 'Good quality mat. Stays in place and easy to clean.', '좋은 품질의 매트. 제자리에 있고 청소하기 쉬워요.', 'Spin L.', 'UK', 4.0, 'en', 'amazon', 178, true, true),

-- UPPAbaby Vista V2
('22222222-2222-2222-2222-222222222238', 'Best stroller investment! Grows with your family. Smooth ride.', '최고의 유모차 투자! 가족과 함께 성장해요. 부드러운 주행.', 'Mom S.', 'US', 5.0, 'en', 'amazon', 456, true, true),
('22222222-2222-2222-2222-222222222238', 'Easy to fold and fits in car trunk. Quality is outstanding.', '접기 쉽고 차 트렁크에 맞아요. 품질이 뛰어나요.', 'Parent K.', 'UK', 4.5, 'en', 'amazon', 345, true, true),

-- Ergobaby Omni 360
('22222222-2222-2222-2222-222222222239', 'So comfortable for both baby and parent. Multiple carry positions.', '아기와 부모 모두에게 정말 편해요. 여러 착용 방법.', 'Dad M.', 'US', 5.0, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222239', 'Lumbar support is a game changer. Baby loves facing out.', '요추 지지대가 획기적이에요. 아기가 바깥을 보는 걸 좋아해요.', 'Mom L.', 'CA', 4.5, 'en', 'amazon', 234, true, true),

-- LEGO Classic
('22222222-2222-2222-2222-222222222240', 'Endless creativity! Kids love it and it keeps them busy for hours.', '끝없는 창의력! 아이들이 좋아하고 몇 시간 동안 바쁘게 해요.', 'Parent J.', 'US', 5.0, 'en', 'amazon', 567, true, true),
('22222222-2222-2222-2222-222222222240', 'Great value for the number of pieces. Quality is classic LEGO.', '피스 수에 비해 가성비가 좋아요. 품질은 클래식 레고예요.', 'Dad T.', 'UK', 4.5, 'en', 'amazon', 345, true, true),

-- Hatch Rest+
('22222222-2222-2222-2222-222222222241', 'Improved our baby sleep routine! The app control is so convenient.', '아기 수면 루틴이 개선됐어요! 앱 제어가 정말 편리해요.', 'Tired M.', 'US', 5.0, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222241', 'White noise options are great. Night light colors are soothing.', '백색소음 옵션이 좋아요. 야간 조명 색상이 편안해요.', 'Sleep D.', 'CA', 4.5, 'en', 'amazon', 234, true, true),

-- Graco 4Ever DLX
('22222222-2222-2222-2222-222222222242', '10 years of use! Best value car seat. Easy to install and adjust.', '10년 사용! 가장 가성비 좋은 카시트. 설치하고 조정하기 쉬워요.', 'Safety F.', 'US', 5.0, 'en', 'amazon', 456, true, true),
('22222222-2222-2222-2222-222222222242', 'Grows with your child. Comfortable padding and good ventilation.', '아이와 함께 성장해요. 편안한 패딩과 좋은 환기.', 'Parent R.', 'UK', 4.5, 'en', 'amazon', 345, true, true),

-- Skip Hop Activity Center
('22222222-2222-2222-2222-222222222243', 'Baby loves it! Keeps her entertained while I cook. Easy to clean.', '아기가 좋아해요! 제가 요리하는 동안 아기를 즐겁게 해줘요. 청소하기 쉬워요.', 'Busy P.', 'US', 4.5, 'en', 'amazon', 234, true, true),
('22222222-2222-2222-2222-222222222243', 'Grows with baby through 3 stages. Good quality toys attached.', '아기와 함께 3단계로 성장해요. 좋은 품질의 장난감이 부착되어 있어요.', 'Mom A.', 'AU', 4.0, 'en', 'amazon', 178, true, true),

-- Philips Hue Starter Kit
('22222222-2222-2222-2222-222222222244', 'Transformed my home! So many color options and scenes to choose from.', '집이 완전히 바뀌었어요! 선택할 수 있는 많은 색상 옵션과 장면.', 'Smart H.', 'US', 5.0, 'en', 'amazon', 456, true, true),
('22222222-2222-2222-2222-222222222244', 'Easy setup with the app. Works great with voice assistants.', '앱으로 쉬운 설정. 음성 비서와 잘 작동해요.', 'Tech L.', 'UK', 4.5, 'en', 'amazon', 345, true, true),

-- Dyson Pure Cool
('22222222-2222-2222-2222-222222222245', 'Air quality improved noticeably. Quiet operation and sleek design.', '공기 질이 눈에 띄게 개선됐어요. 조용한 작동과 세련된 디자인.', 'Allergy S.', 'US', 4.5, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222245', 'App shows real-time air quality. Filter replacement is easy.', '앱이 실시간 공기 질을 보여줘요. 필터 교체가 쉬워요.', 'Clean A.', 'UK', 4.0, 'en', 'amazon', 234, true, true),

-- iRobot Roomba j7+
('22222222-2222-2222-2222-222222222246', 'Avoids pet accidents like magic! Self emptying base is a must have.', '마법처럼 반려동물 사고를 피해요! 자동 비움 베이스는 필수예요.', 'Pet O.', 'US', 4.5, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222246', 'Smart mapping works great. Schedules cleaning while I am at work.', '스마트 매핑이 잘 작동해요. 제가 직장에 있는 동안 청소를 예약해요.', 'Busy W.', 'CA', 4.0, 'en', 'amazon', 234, true, true),

-- Casper Mattress
('22222222-2222-2222-2222-222222222247', 'Best sleep of my life! Perfect firmness and no motion transfer.', '인생 최고의 수면! 완벽한 단단함과 움직임 전달 없음.', 'Sleep W.', 'US', 4.5, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222247', '100 night trial gave me confidence to buy. No regrets at all.', '100일 체험이 구매할 자신감을 줬어요. 전혀 후회 없어요.', 'Rest E.', 'UK', 4.5, 'en', 'amazon', 234, true, true),

-- Nest Thermostat
('22222222-2222-2222-2222-222222222248', 'Saved money on energy bills! Learns my schedule automatically.', '에너지 비용을 절약했어요! 제 일정을 자동으로 학습해요.', 'Eco F.', 'US', 4.5, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222248', 'Easy installation and setup. Remote control from phone is convenient.', '쉬운 설치와 설정. 폰에서 원격 제어가 편리해요.', 'Smart T.', 'CA', 4.0, 'en', 'amazon', 234, true, true),

-- Sonos One SL
('22222222-2222-2222-2222-222222222249', 'Rich sound for its size. Multi room audio is seamless.', '크기에 비해 풍부한 사운드. 멀티룸 오디오가 매끄러워요.', 'Audio M.', 'US', 5.0, 'en', 'amazon', 345, true, true),
('22222222-2222-2222-2222-222222222249', 'AirPlay 2 works perfectly with iPhone. Compact and powerful.', 'AirPlay 2가 아이폰과 완벽하게 작동해요. 컴팩트하고 강력해요.', 'Music L.', 'UK', 4.5, 'en', 'amazon', 234, true, true),

-- West Elm Desk
('22222222-2222-2222-2222-222222222250', 'Beautiful mid century design. Solid wood construction feels premium.', '아름다운 미드센추리 디자인. 단단한 나무 구조가 프리미엄 느낌이에요.', 'WFH D.', 'US', 4.5, 'en', 'amazon', 234, true, true),
('22222222-2222-2222-2222-222222222250', 'Assembly was straightforward. Perfect size for home office.', '조립이 간단했어요. 홈오피스에 완벽한 사이즈예요.', 'Home O.', 'CA', 4.0, 'en', 'amazon', 178, true, true);

-- ============================================
-- 완료 확인
-- ============================================

SELECT 'Categories' as table_name, COUNT(*) as count FROM public.categories
UNION ALL
SELECT 'Products', COUNT(*) FROM public.products
UNION ALL
SELECT 'External Reviews', COUNT(*) FROM public.external_reviews;

