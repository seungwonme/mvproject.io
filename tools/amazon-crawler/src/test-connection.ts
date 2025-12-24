/**
 * @file test-connection.ts
 * @description Supabase 연결 테스트
 */

import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';

async function testConnection() {
  console.log('🔍 Supabase 연결 테스트 시작...\n');

  const supabaseUrl = process.env.SUPABASE_URL || process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    console.error('❌ 환경 변수가 설정되지 않았습니다.');
    console.log('   SUPABASE_URL:', supabaseUrl ? '설정됨' : '없음');
    console.log('   SUPABASE_SERVICE_ROLE_KEY:', supabaseKey ? '설정됨' : '없음');
    process.exit(1);
  }

  console.log('📋 환경 변수:');
  console.log(`   SUPABASE_URL: ${supabaseUrl.substring(0, 30)}...`);
  console.log(`   SUPABASE_SERVICE_ROLE_KEY: ${supabaseKey.substring(0, 20)}...`);
  console.log('');

  try {
    const supabase = createClient(supabaseUrl, supabaseKey);

    // products 테이블 조회 테스트
    const { data, error, count } = await supabase
      .from('products')
      .select('*', { count: 'exact', head: true });

    if (error) {
      console.error('❌ 쿼리 오류:', error.message);
      process.exit(1);
    }

    console.log('✅ Supabase 연결 성공!');
    console.log(`   📦 현재 products 테이블: ${count}개 레코드`);
    
    // Amazon 상품 수 확인
    const { count: amazonCount } = await supabase
      .from('products')
      .select('*', { count: 'exact', head: true })
      .eq('source_platform', 'amazon');
    
    console.log(`   🛒 Amazon 상품: ${amazonCount || 0}개`);
    
  } catch (err) {
    console.error('❌ 연결 실패:', err);
    process.exit(1);
  }
}

testConnection();

