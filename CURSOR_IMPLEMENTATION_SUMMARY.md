# 커서 캐릭터 애니메이션 구현 요약

## 1. 개요
사용자가 요청한 `jigooinshop.com` 사이트의 마우스 따라다니는 캐릭터 효과를 분석하고, 사용자의 이미지를 사용하여 유사한 기능을 구현하였습니다. 단순한 이미지 추적을 넘어, 코드를 통해 "걷는 듯한" 생동감을 부여했습니다.

## 2. 작업 상세 내용

### 2.1 사이트 분석 (Browser Agent)
- **대상 사이트**: `https://jigooinshop.com/`
- **관찰 결과**:
  - 캐릭터가 마우스를 부드럽게 따라다님 (Lag/Delay 효과).
  - 움직일 때 프레임 애니메이션(걷는 동작)이 존재.
  - 회전이나 잔상 효과는 없음.
- **결론**: Canvas보다는 DOM 엘리먼트(`div`, `img`)를 JS로 제어하는 방식이 적합하다고 판단.

### 2.2 리소스 배치
- **이미지**: 사용자가 업로드한 이미지를 프로젝트의 정적 파일 경로로 이동.
- **경로**: `public/cursor-character.png`

### 2.3 컴포넌트 구현 (`components/custom-cursor.tsx`)
React의 `useRef`와 `requestAnimationFrame`을 사용하여 고성능 애니메이션을 구현했습니다.

- **기능적 특징**:
  1.  **마우스 좌측 하단 배치**: 마우스 포인터 기준 좌측(-20px), 하단(+15px) 오프셋 적용.
  2.  **Lerp (Linear Interpolation)**: 마우스 위치를 즉시 따라가지 않고 가중치(`0.15`)를 두어 부드럽게 뒤따라오는 효과 구현.
  3.  **절차적 애니메이션 (Procedural Animation)**: 별도의 스프라이트 시트(걷는 동작 이미지들) 없이 코드만으로 걷는 느낌 구현.
      - **Bobbing (위아래 들썩임)**: 이동 속도에 비례하여 `sin` 파동으로 Y축 움직임 생성.
      - **Tilting (기울임)**: 이동 방향으로 약간 기울어지게 하여 역동성 추가.
  4.  **방향 전환**: 마우스가 왼쪽/오른쪽으로 이동할 때 `scaleX`를 조정하여 캐릭터가 진행 방향을 바라보게 처리. 이전 방향 유지 로직 포함.
  5.  **최적화**: `useState`를 최소화하고 `useRef`로 좌표를 관리하여 불필요한 리렌더링 방지.
  6.  **초기 위치 동기화**: 첫 마우스 이동 시 즉시 해당 위치로 이동하여 날아오는 현상 방지.

### 2.4 전역 적용 (`app/layout.tsx`)
- 모든 페이지에서 커서 효과가 나타나도록 최상위 레이아웃 파일에 컴포넌트 추가.
- `SyncUserProvider` 외부에 배치하여 UI 구조와 독립적으로 작동.

## 3. 결과물 구조

```tsx
// components/custom-cursor.tsx (핵심 로직 예시)

// 캐릭터 위치 오프셋 (마우스 포인터 기준 좌측 하단)
const CURSOR_OFFSET_X = -20; // 좌측으로 이동
const CURSOR_OFFSET_Y = 15;  // 하단으로 이동

const animate = () => {
  // 부드러운 추적
  currentPos.x += (mousePos.x - currentPos.x) * LERP_FACTOR;
  
  // 속도 기반 걷는 모션 계산
  if (isMoving) {
     const bobOffset = Math.sin(walkCycle) * 4; // 위아래
     const rotation = Math.sin(walkCycle) * 5;  // 회전
  }
  
  // 좌측 하단 오프셋 적용
  const finalX = currentPos.x + CURSOR_OFFSET_X;
  const finalY = currentPos.y + CURSOR_OFFSET_Y + bobOffset;
  
  content.style.transform = `translate3d(${finalX}px, ${finalY}px, 0) ...`;
}
```

## 4. 설정 가능한 파라미터

| 상수명 | 기본값 | 설명 |
|--------|--------|------|
| `CURSOR_OFFSET_X` | -20 | 마우스 기준 X축 오프셋 (음수: 좌측) |
| `CURSOR_OFFSET_Y` | 15 | 마우스 기준 Y축 오프셋 (양수: 하단) |
| `LERP_FACTOR` | 0.15 | 추적 부드러움 (낮을수록 느리게 따라옴) |

## 5. 추후 개선 가능 사항
- **이미지 교체**: `public/cursor-character.png` 파일만 바꾸면 캐릭터 변경 가능.
- **파라미터 조정**: 상단 상수들을 조절하여 캐릭터의 위치, "무게감"이나 "발랄함" 수정 가능.
