# 프론트엔드 인터랙티브 요소 구현 요약

## 1. 개요
본 문서는 사용자 경험(UX) 향상을 위해 사이트에 추가된 두 가지 핵심 시각적 기능인 **커서 캐릭터 애니메이션**과 **동적 실사 배경**의 구현 내용을 정리합니다.

## 2. 주요 구현 기능

### 2.1 커서 캐릭터 애니메이션 (Walking Character Cursor)
마우스 커서를 따라다니는 캐릭터에 생동감을 부여하기 위해 단순 이동뿐만 아니라 "걷는 듯한" 효과를 절차적 애니메이션으로 구현했습니다.

- **컴포넌트**: `components/custom-cursor.tsx`
- **주요 로직**:
  - **Lerp (Linear Interpolation)**: 마우스 위치와 캐릭터 위치 간의 선형 보간을 통해 부드러운 추적 효과(Lag) 구현.
  - **Procedural Animation**: 별도의 프레임 이미지 없이 코드로 동작 생성.
    - **Bobbing**: 이동 속도에 따라 Y축으로 들썩이는 효과.
    - **Tilting**: 이동 방향으로 캐릭터가 살짝 기울어지는 효과.
  - **Direction Flip**: 이동 방향(좌/우)에 따라 캐릭터 좌우 반전.
- **리소스**: `public/KakaoTalk_20251224_134851796-removebg-preview.png` (배 이미지)

### 2.2 동적 실사 배경 (Immersive Sky Background)
사이트 전체에 웅장하고 깊이감 있는 하늘 배경을 적용하여 "모험"의 테마를 시각화했습니다.

- **컴포넌트**: `components/DynamicBackground.tsx`
- **주요 로직**:
  - **Global Fixed Background**: `layout.tsx`에 `z-index: -50`으로 배치하여 모든 페이지 뒤에 고정.
  - **Realistic Asset**: 사용자가 제공한 8K급 실사 하늘 이미지(`public/sky-bg.png`) 사용.
  - **Artifact Correction**: 원본 이미지 상단의 불필요한 UI 흔적을 제거하기 위해 `background-position`을 조정(`-100px`)하여 크롭 처리.
  - **Slow Zoom Animation**: 정지된 이미지가 지루하지 않도록 20초 주기의 아주 느린 확대/축소(`scale(1)` ↔ `scale(1.05)`) 애니메이션 적용 (`app/globals.css`).
  - **Overlay**: 텍스트 가독성 확보를 위한 10% 검은색 오버레이 추가.

## 3. 적용 위치
모든 기능은 **`app/layout.tsx`** (Root Layout)에 통합되어 사이트 전역에서 동작합니다.

```tsx
// app/layout.tsx 구조
<body className={...}>
  <DynamicBackground /> {/* 전역 배경 */}
  <SyncUserProvider>
    <Navbar />
    {children}
  </SyncUserProvider>
  <CustomCursor />      {/* 전역 커서 */}
</body>
```

## 4. 관련 파일 목록
- `components/custom-cursor.tsx`: 커서 로직
- `components/DynamicBackground.tsx`: 배경 로직
- `app/layout.tsx`: 컴포넌트 통합
- `app/globals.css`: 배경 애니메이션 (`@keyframes slow-zoom`)
- `public/KakaoTalk_20251224_134851796-removebg-preview.png`: 커서 이미지 (배)
- `public/sky-bg.png`: 배경 이미지
