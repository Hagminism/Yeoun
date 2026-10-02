# Memory 서비스 PRD v1.0

## 1. 제품 개요

### 1.1 제품명

가칭 **Memory**

정식 서비스명은 추후 확정한다.

---

### 1.2 한 줄 소개

**기억하고 싶은 순간과 경험을 혼자 또는 소중한 사람들과 기록하고, 시간이 지난 뒤 다시 발견할 수 있도록 돕는 Memory 서비스**

---

### 1.3 제품 형태

초기 버전은 **Flutter Web 기반 모바일 우선 웹앱**으로 제공한다.

향후 서비스 확장 시 동일한 Flutter 코드베이스와 Spring Boot Backend를 기반으로 Android/iOS 앱 출시를 고려한다.

---

# 2. 제품 배경

사용자의 기억과 경험은 여러 서비스에 흩어져 있다.

예를 들어:

- 사진은 스마트폰 갤러리
- 여행 기록은 SNS
- 본 영화는 별도의 영화 서비스
- 가고 싶은 장소는 지도
- 버킷리스트는 메모 앱
- 기념일은 캘린더

등으로 분산되어 있다.

본 서비스는 이러한 경험을 하나의 제품 안에서 기록할 수 있도록 하되, 모든 기능을 하나의 기술적 Domain으로 통합하지 않는다.

각 기능은 독립적인 Feature로 운영하지만 사용자는 이 모든 활동을 **Memory를 남기는 하나의 경험**으로 인식하도록 설계한다.

---

# 3. 제품 목표

본 서비스는 다음 네 가지 사용자 경험을 제공하는 것을 목표로 한다.

## 3.1 Record

현재의 순간과 경험을 기록한다.

## 3.2 Together

필요한 경우 다른 사람들과 같은 Space 안에서 기록을 함께 쌓는다.

## 3.3 Remember

시간이 지난 뒤 과거의 기록을 다시 발견한다.

## 3.4 Future

현재의 기록을 미래의 특정 시점에 다시 만날 수 있도록 한다.

---

# 4. 비목표

본 서비스는 사용자 간 실시간 커뮤니케이션 서비스를 목표로 하지 않는다.

다음 기능은 제품 범위에서 제외한다.

- 실시간 채팅
- 음성 통화
- 영상 통화
- 공개 SNS Feed
- 불특정 사용자 대상 Follow 시스템
- 인플루언서 중심 콘텐츠 소비 구조

사용자 간 상호작용은 Memory와 관련된 기능으로 제한한다.

예:

- 댓글
- Reaction
- 공동 기록
- 타임캡슐
- 질문 답변

---

# 5. 핵심 사용자

본 서비스의 핵심 사용자는 다음과 같다.

> **기억하고 싶은 순간과 경험을 혼자 또는 소중한 사람들과 남기고 싶은 사람**
>

연령대는 주로 10대 후반부터 30대까지의 사용자를 주요 대상으로 고려한다.

사용자의 관계 형태에 따라 다음과 같은 사용 시나리오를 제공한다.

---

## 5.1 개인

- 나만의 일상 기록
- 개인 여행
- 영화 기록
- 장소 기록
- 버킷리스트
- 미래의 나에게 타임캡슐

---

## 5.2 연인

- 데이트 기록
- 함께 본 영화
- 여행
- 기념일
- 버킷리스트
- 공동 타임캡슐

---

## 5.3 친구

- 학교생활
- 여행
- 모임
- 문화생활
- 그룹 버킷리스트
- 졸업 후 타임캡슐

---

## 5.4 가족

- 가족 여행
- 가족 행사
- 성장 기록
- 가족 사진
- 미래 가족 구성원에게 남기는 기록

---

# 6. 핵심 제품 구조

서비스는 다음 구조를 중심으로 구성한다.

```
User
  │
  ├─ Space A
  │    ├─ Movie
  │    ├─ Travel
  │    ├─ Bucket
  │    └─ Time Capsule
  │
  ├─ Space B
  │    ├─ Place
  │    └─ Movie
  │
  └─ Space C
       └─ ...
```

`Space`는 모든 Feature가 동작하는 최상위 Context이다.

---

# 7. Space

## 7.1 정의

Space는 사용자가 기록을 남기고 Feature를 사용하는 독립적인 공간이다.

Space는 최소 1명의 사용자를 가진다.

---

## 7.2 Space 유형

별도의 기술적 Type으로 강제하지 않더라도 다음 사용 형태를 지원한다.

### 개인 Space

사용자 1명만 존재한다.

예:

- 나의 기록
- 영화 기록
- 올해의 나

### 2인 Space

예:

- 연인
- 친구
- 가족

### 그룹 Space

예:

- 대학 친구
- 여행 멤버
- 가족
- 동아리

---

## 7.3 다중 Space

한 사용자는 여러 Space를 생성하거나 참여할 수 있어야 한다.

예:

```
나의 기록
우리 둘
가족
대학교 친구들
```

각 Space의 데이터와 Widget 구성은 독립적으로 관리한다.

---

# 8. Space Dashboard

Space에 진입하면 Dashboard를 제공한다.

Dashboard는 여러 Feature Widget으로 구성된다.

예:

```
Movie
Bucket List
Travel
Place
Time Capsule
Anniversary
```

사용자는 원하는 Widget을 Space에 추가할 수 있다.

Widget은 **Feature 자체가 아니라 해당 Feature로 진입하거나 요약 정보를 확인하기 위한 Entry Point**이다.

---

# 9. Widget 구성

## 9.1 SpaceWidgetConfig

Space Dashboard의 Widget 구성 정보는 별도 데이터로 관리한다.

개념적으로 다음 정보를 가진다.

```
id
spaceId
type
position
visible
```

---

## 9.2 Widget Type

Widget Type은 Enum으로 관리한다.

예:

```
MOVIE
TRAVEL
BUCKET
PLACE
CAPSULE
ANNIVERSARY
```

---

## 9.3 Widget Position

사용자가 Widget을 추가하거나 순서를 변경할 수 있도록 한다.

서버는 `position` 기준으로 정렬하여 Widget 목록을 반환한다.

Flutter는 반환된 순서대로 Widget을 렌더링한다.

---

## 9.4 Widget Rendering

Flutter에서는 공통 Wrapper를 이용하여 Widget Type에 맞는 Feature UI를 출력한다.

개념 예:

```
SpaceWidgetConfig
        │
        ▼
SpaceWidgetWrapper
        │
        ├─ MOVIE   → MovieWidget
        ├─ BUCKET  → BucketWidget
        └─ CAPSULE → CapsuleWidget
```

---

# 10. Feature Architecture

각 Widget이 나타내는 Feature는 독립적인 Domain으로 관리한다.

예:

```
Movie
→ MovieRecord

Travel
→ Trip / TravelRecord

Bucket
→ BucketItem

Capsule
→ TimeCapsule
```

각 Feature는 자신의:

- Data
- Business Rule
- Lifecycle
- API
- State

를 독립적으로 소유한다.

---

## 10.1 Feature 간 관계

Feature 간 직접적인 Data 공유와 의존은 기본적으로 피한다.

예를 들어:

```
MovieRecord → TravelRecord
```

처럼 하나의 Feature Data가 다른 Feature의 핵심 Domain Data로 사용되지 않도록 한다.

다만 하나의 화면에서 여러 Feature 정보를 함께 보여주는 것은 가능하다.

예:

```
Movie
Travel
Place
Capsule
   ↓
RecentActivityResponse
```

이는 조회 및 Presentation을 위한 집계로 간주한다.

---

# 11. Memory 정의

Memory는 제품 전체를 관통하는 사용자 경험 개념이다.

사용자 관점에서는 다음과 같은 항목이 모두 Memory가 될 수 있다.

- 함께 본 영화
- 방문한 장소
- 여행
- 사진
- 완료한 버킷리스트
- 타임캡슐
- 기념일

하지만 Backend에서는 하나의 Global Memory Entity로 통합하지 않는다.

각 Feature는 독립적인 Domain Model과 Entity를 사용할 수 있다.

---

# 12. Collection

여러 기록을 묶는 기능이 필요한 경우 해당 Feature 내부에서 Collection을 정의할 수 있다.

예를 들어 Travel Feature:

```
Trip: 제주 여행

├─ TravelRecord
├─ TravelRecord
└─ TravelRecord
```

전역 `MemoryCollection`을 기본 Domain으로 두지는 않는다.

Collection은 실제 Feature 요구사항이 존재할 때 Feature별로 설계한다.

---

# 13. Core Feature 후보

초기 제품에서 고려하는 Feature는 다음과 같다.

## 13.1 일반 기록

사진과 짧은 글을 남길 수 있는 가장 기본적인 기록 기능.

---

## 13.2 Movie / Culture

사용자가 본 영화, 드라마 등의 문화 콘텐츠를 기록할 수 있다.

후보 정보:

- 작품
- 감상 날짜
- 평점
- 감상평

상세 데이터는 Feature 개발 전 별도 설계한다.

---

## 13.3 Place

사용자가 방문한 장소 또는 맛집을 기록할 수 있다.

후보 정보:

- 장소
- 방문 날짜
- 사진
- 간단한 후기

---

## 13.4 Travel

여행을 하나의 단위로 관리할 수 있다.

여행 내부에 여러 기록을 포함할 수 있는 구조를 고려한다.

세부 구조는 Travel Feature 개발 전 정의한다.

---

## 13.5 Bucket List

사용자가 앞으로 하고 싶은 경험을 기록한다.

예:

- 제주도 여행
- 같이 콘서트 가기
- 올해 책 10권 읽기

완료 여부와 완료 시점 등을 관리한다.

세부 Lifecycle은 Feature 개발 전 정의한다.

---

# 14. Time Capsule

Time Capsule은 서비스의 대표적인 차별화 Feature이다.

일반 기록 기능이 서비스의 중심이며, Time Capsule은 Memory 서비스의 감성적 특징을 강화하는 기능으로 제공한다.

---

## 14.1 개인 Time Capsule

사용자는 미래의 자신에게 기록을 남길 수 있다.

예:

> 1년 뒤의 나에게
>

---

## 14.2 공유 Time Capsule

공유 Space의 여러 사용자가 하나의 Capsule에 참여할 수 있다.

---

## 14.3 공개 시점

사용자는 Capsule 공개 시점을 설정할 수 있다.

예:

- 특정 날짜
- 100일 뒤
- 1년 뒤

---

## 14.4 상태

개념적으로 다음 Lifecycle을 고려한다.

```
DRAFT
 ↓
SEALED
 ↓
OPENED
```

상세 정책은 Feature 개발 전 정의한다.

---

# 15. Memory 재발견

서비스는 기록을 저장하는 기능뿐 아니라 과거의 기록을 다시 발견하도록 돕는다.

후보 기능은 다음과 같다.

---

## 15.1 과거의 오늘

과거 동일 날짜의 기록을 다시 보여준다.

예:

> 1년 전 오늘
>

---

## 15.2 첫 기록

오래된 Space의 초기 기록을 다시 보여준다.

예:

> 우리가 처음 남긴 기록을 기억하나요?
>

---

## 15.3 기념일 회고

특정 기간 또는 기념일에 과거 기록을 다시 보여준다.

---

# 16. AI 회고

AI는 서비스의 중심 기능이 아니라 **축적된 Memory를 다시 의미 있게 소비하도록 돕는 기능**으로 사용한다.

---

## 16.1 AI 활용 목적

AI는 다음과 같은 기록을 생성한다.

- 월간 회고
- 연간 회고
- 여행 회고
- 특정 이벤트 회고
- Space 기념일 회고

---

## 16.2 예시

```
우리의 2027년

Memory 83개
방문한 장소 24곳
함께 본 영화 17편
완료한 버킷리스트 8개

올해는 여행과 새로운 장소에 대한 기록이 많았어요.
특히 8월에 가장 많은 순간을 남겼습니다.
```

---

## 16.3 AI 원칙

AI는 사용자 기록을 기반으로 회고를 작성한다.

실제 기록에 존재하지 않는 경험을 임의로 생성하지 않도록 한다.

AI 기능 장애 또는 API 비용 문제가 발생하더라도 일반 Feature는 정상적으로 동작해야 한다.

---

# 17. 인증

초기 버전은 소셜 로그인 기반으로 제공한다.

지원 Provider:

- Google
- Kakao
- Naver

---

## 17.1 인증 Flow

```
Flutter
   ↓
Social Provider Login
   ↓
ID Token
   ↓
Spring Boot
   ↓
OIDC Verification
   ↓
User 조회 또는 생성
   ↓
Service JWT 발급
```

---

## 17.2 Service JWT

소셜 Provider Token은 신원 확인에 사용한다.

이후 API 요청에는 서비스에서 발급한 Access Token과 Refresh Token을 사용한다.

JWT 구조를 통해 Web, Android, iOS에서 동일한 Backend API를 사용할 수 있도록 한다.

---

# 18. 초대

공유 Space에는 다른 사용자를 초대할 수 있다.

초대 링크를 통해 다른 사용자가 Space에 참여할 수 있도록 한다.

---

## 18.1 초대 Flow

```
Space
 ↓
Invite Link 생성
 ↓
외부 메신저로 공유
 ↓
상대방 Link 접근
 ↓
로그인
 ↓
Space 참여
```

로그인 이전에 초대 링크로 진입한 경우 로그인 이후에도 초대 정보가 유지되어야 한다.

---

# 19. 사용자 상호작용

실시간 커뮤니케이션 기능은 제공하지 않는다.

대신 Memory와 관련된 제한적인 상호작용을 제공할 수 있다.

후보:

- 댓글
- Reaction
- 공동 작성
- 공동 Capsule

MVP 포함 여부는 Feature 우선순위에 따라 결정한다.

---

# 20. Frontend Architecture

Frontend는 Flutter를 사용한다.

Clean Architecture 기반으로 Feature를 분리한다.

예:

```
features/

├─ auth/
├─ space/
├─ movie/
├─ travel/
├─ bucket/
├─ capsule/
└─ ...
```

각 Feature는 필요에 따라 다음 계층을 갖는다.

```
presentation
domain
data
```

---

## 20.1 State Management

Riverpod을 사용한다.

각 화면은 기본적으로 다음 구조를 따른다.

```
Screen
 ↓
ViewModel / Notifier
 ↓
State
```

한 화면당 독립적인 State를 관리한다.

---

## 20.2 Space State

`SpaceState`는 Space 화면 자체의 상태만 관리한다.

예:

```
currentSpace
widgetConfigs
isLoading
error
```

각 Feature의 상세 Data는 해당 Feature ViewModel/State에서 관리한다.

---

# 21. Backend Architecture

Backend는 Spring Boot를 사용한다.

Feature 또는 Domain 단위로 패키지를 분리한다.

예:

```
auth
space
movie
travel
bucket
capsule
```

각 Feature는 필요에 따라 다음 구성요소를 가진다.

```
Controller
Service
Repository
Entity
DTO
Mapper
```

Feature 복잡도에 맞게 구조를 적용한다.

---

# 22. Database / Storage

## 22.1 Database

Supabase PostgreSQL을 사용한다.

Spring Boot는 JPA/JDBC를 통해 PostgreSQL에 접근한다.

Flutter는 Database에 직접 접근하지 않는다.

---

## 22.2 Storage

이미지 및 향후 미디어 파일은 Supabase Storage를 사용한다.

DB에는 Storage Path 및 Metadata를 저장한다.

---

# 23. 배포

초기 배포 구조는 다음과 같은 방향을 고려한다.

```
Flutter Web
   ↓
Cloudflare Pages 또는 Vercel

Spring Boot
   ↓
Railway 또는 Render

Database / Storage
   ↓
Supabase
```

최종 서비스는 Custom Domain을 사용하도록 고려한다.

예:

```
example.com
api.example.com
```

---

# 24. MVP 목표

초기 MVP는 모든 Feature를 구현하는 것을 목표로 하지 않는다.

서비스의 핵심 구조와 사용자 경험을 검증할 수 있는 수준을 목표로 한다.

---

## 24.1 MVP 필수 Flow

### Flow A — 로그인

```
서비스 진입
→ 소셜 로그인
→ User 생성 또는 조회
```

### Flow B — Space

```
Space 생성
→ Space 진입
→ Widget 확인
```

### Flow C — Widget

```
Widget 추가
→ Dashboard 배치
→ 저장
→ 재접속 후 동일 순서 복원
```

### Flow D — 기본 기록

```
Feature 진입
→ 기록 생성
→ 조회
→ 수정/삭제
```

### Flow E — 초대

```
Invite Link 생성
→ 상대방 로그인
→ Space 참여
```

### Flow F — Time Capsule

```
Capsule 생성
→ 공개 시점 설정
→ 봉인
→ 지정 시점 이후 공개
```

---

# 25. MVP Feature 후보

MVP에서는 다음 Feature 조합을 우선 고려한다.

### 필수

- Auth
- Space
- SpaceWidgetConfig
- 일반 Memory 성격의 기본 기록 Feature
- Time Capsule

### 선택

- Movie
- Bucket
- Place

초기 Feature 수는 개발 진행 상황에 따라 최소화한다.

---

# 26. 개발 방식

본 프로젝트는 Spring Boot 학습과 병행한다.

따라서 전체 Feature를 사전에 상세 설계하지 않는다.

프로젝트 전체의 Architecture 및 Requirement Baseline만 먼저 확정한다.

각 Feature는 실제 개발 직전 별도의 Mini Spec을 작성한다.

---

# 27. Feature Mini Spec

각 Feature 구현 전 다음 항목을 정의한다.

1. 사용자 목적
2. 핵심 User Flow
3. 주요 Data
4. Domain / Entity
5. Lifecycle
6. API
7. Flutter State
8. 예외 상황
9. 다른 Domain과의 관계
10. 테스트 항목

---

# 28. 개발 원칙

본 프로젝트는 **Just-in-Time Design** 방식을 따른다.

```
큰 제품 원칙 확정
        ↓
Feature 선정
        ↓
Feature 요구사항 분석
        ↓
Mini Spec
        ↓
구현
        ↓
실제 문제 발견
        ↓
Spec 수정
        ↓
리팩터링
```

초기 설계 단계에서 아직 존재하지 않는 Feature의 DB Schema, API, State 구조를 지나치게 구체화하지 않는다.

---

# 29. 현재 확정된 제품 및 모델링 원칙

1. **Memory는 제품의 핵심 개념이다.**
2. **Memory는 반드시 하나의 전역 Entity일 필요는 없다.**
3. **Space는 모든 Feature가 존재하는 Context이다.**
4. **Space는 1명 이상의 사용자를 지원한다.**
5. **Widget은 Feature로 진입하기 위한 UI Entry Point이다.**
6. **SpaceWidgetConfig는 Dashboard 구성 정보만 관리한다.**
7. **각 Feature는 독립적인 Domain으로 설계한다.**
8. **각 Feature는 자신의 Data와 Lifecycle을 소유한다.**
9. **Feature 간 직접적인 Data 공유는 기본적으로 피한다.**
10. **여러 Feature를 통합해서 보여줘야 하는 경우 Presentation/Query 계층에서 집계한다.**
11. **Collection은 필요한 Feature 내부에서만 설계한다.**
12. **Time Capsule은 서비스의 대표 감성 Feature이다.**
13. **AI는 기존 기록을 재구성하고 회고하는 역할로 사용한다.**
14. **채팅·음성통화·영상통화는 제품 범위에서 제외한다.**
15. **각 Feature의 상세 설계는 개발 직전에 수행한다.**

---

# 30. 제품 성공 기준

초기 제품의 성공은 Feature 개수보다 다음 핵심 경험이 자연스럽게 동작하는지로 판단한다.

### 사용자가 쉽게 시작할 수 있는가?

소셜 로그인 후 빠르게 Space를 만들 수 있어야 한다.

### 원하는 기능을 직접 구성할 수 있는가?

사용자가 원하는 Widget을 Space에 추가하고 원하는 순서로 배치할 수 있어야 한다.

### 기록을 지속적으로 쌓을 수 있는가?

Feature별 기록 생성과 탐색이 자연스럽게 이루어져야 한다.

### 다른 사람과 함께 사용할 수 있는가?

초대 링크를 통해 다른 사용자가 쉽게 Space에 참여할 수 있어야 한다.

### 시간이 지나도 다시 사용할 이유가 있는가?

Time Capsule, 과거 기록 재발견, 회고 기능 등을 통해 시간이 흐를수록 서비스 가치가 증가해야 한다.

---

# 31. 핵심 제품 방향

본 서비스는 여러 기능을 단순히 한 곳에 모아둔 도구 모음을 목표로 하지 않는다.

각 Feature는 독립적으로 동작하지만 사용자에게는 모두 하나의 경험으로 연결되어야 한다.

> **지금의 순간을 남기고,시간이 지나 다시 만나고,기억하고 싶은 삶의 조각을 쌓아가는 공간**
>

서비스의 모든 Feature는 이 제품 방향을 강화하는 범위 안에서 설계한다.