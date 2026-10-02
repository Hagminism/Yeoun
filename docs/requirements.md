# Memory 서비스 요구사항 분석 v0.3

## 1. 서비스 정의

본 서비스는 **기억하고 싶은 순간과 경험을 혼자 또는 소중한 사람들과 기록하고, 시간이 지난 뒤 다시 발견할 수 있도록 하는 Memory 서비스**이다.

`Memory`는 제품 전체를 관통하는 **제품 개념**이며, 반드시 하나의 공통 DB Entity 또는 Table을 의미하지 않는다.

각 기능은 Memory라는 공통 제품 테마 아래 독립적인 Feature로 구성될 수 있다.

---

## 2. 핵심 제품 원칙

서비스에서 제공하는 기능은 다음 중 하나 이상의 목적을 가져야 한다.

- 새로운 기억이나 경험을 기록한다.
- 기존 기록을 다시 발견하게 한다.
- 기록된 경험을 새로운 형태로 회고하게 한다.
- 미래에 다시 만나기 위한 기록을 남긴다.

실시간 연락을 목적으로 하는 기능은 제품 범위에서 제외한다.

따라서 다음 기능은 제공하지 않는다.

- 채팅
- 음성통화
- 영상통화

댓글이나 Reaction 등은 연락 수단이 아니라 **기록에 대한 상호작용**으로 간주한다.

---

## 3. Space

`Space`는 사용자가 Feature와 기록을 사용하는 최상위 Context이다.

Space에는 최소 1명의 사용자가 존재한다.

따라서 다음 형태를 모두 지원할 수 있다.

```
개인 Space
→ 나만의 기록

2인 Space
→ 연인 / 친구 / 가족

다인 Space
→ 친구 / 가족 / 여행 / 모임 등
```

한 사용자는 여러 Space에 참여할 수 있다.

각 Space의 데이터는 서로 독립적이어야 한다.

---

## 4. Space Dashboard

Space의 홈 화면은 여러 Feature Widget으로 구성된다.

사용자는 자신이 원하는 Widget을 Space에 추가하고 배치할 수 있다.

예:

```
Space

├─ Movie
├─ Bucket List
├─ Travel
├─ Place
├─ Time Capsule
└─ ...
```

Widget은 **기능 자체가 아니라 해당 기능으로 진입하는 UI Entry Point**이다.

---

## 5. SpaceWidgetConfig

Space Dashboard의 구성은 별도의 설정 데이터로 관리한다.

개념적으로 다음과 같은 정보를 가진다.

```
SpaceWidgetConfig

id
spaceId
type
position
visible
```

`type`은 Enum으로 관리한다.

예:

```
MOVIE
BUCKET
TRAVEL
PLACE
CAPSULE
...
```

`position`을 기준으로 서버에서 정렬하여 클라이언트에 전달한다.

Flutter에서는 전달받은 `List<SpaceWidgetConfig>` 순서대로 렌더링한다.

각 Config는 Wrapper를 통해 실제 Widget으로 매핑된다.

```
MOVIE
  ↓
MovieWidget

BUCKET
  ↓
BucketWidget

CAPSULE
  ↓
CapsuleWidget
```

---

## 6. Feature 독립성

각 Widget이 나타내는 Feature는 **독립적인 Domain으로 동작하는 것을 기본 원칙으로 한다.**

예:

```
Movie
→ MovieRecord

Bucket
→ BucketItem

Travel
→ Trip / TravelRecord

Capsule
→ TimeCapsule
```

Movie Feature에서 생성한 데이터를 Travel Feature가 직접 참조하거나, 하나의 Record를 여러 Feature가 공동 소유하는 구조는 기본적으로 사용하지 않는다.

다음과 같은 전역 Memory 중심 구조를 강제하지 않는다.

```
Global Memory
      │
 ┌────┼────┐
Movie Travel Place
```

대신 각 Domain이 자신의 데이터를 독립적으로 관리한다.

```
Space
 │
 ├─ Movie Domain
 │    └─ MovieRecord
 │
 ├─ Travel Domain
 │    └─ TravelRecord
 │
 ├─ Bucket Domain
 │    └─ BucketItem
 │
 └─ Capsule Domain
      └─ TimeCapsule
```

각 Feature가 자신의 데이터와 비즈니스 규칙을 소유한다.

---

## 7. Memory의 의미

`Memory`는 DB 전체를 통합하기 위한 기술적 추상화가 아니라 **제품의 상위 개념**으로 사용한다.

따라서 사용자 관점에서는 다음 모두 Memory 경험의 일부가 될 수 있다.

- 같이 본 영화
- 방문한 장소
- 여행
- 사진 기록
- 완료한 버킷리스트
- 타임캡슐

하지만 Backend에서는 각각 다른 Entity와 Domain으로 구현될 수 있다.

---

## 8. Feature 간 결합

Feature 간 직접적인 Domain 의존은 최소화한다.

예를 들어 다음과 같은 구조는 기본적으로 피한다.

```
MovieRecord
   ↓
TravelRecord
   ↓
BucketItem
```

다만 하나의 화면에서 여러 Feature 정보를 보여주는 것은 허용한다.

예:

```
Movie ───────┐
Travel ──────┤
Place ───────┼→ RecentActivityResponse
Capsule ─────┘
```

이는 **조회 또는 Presentation을 위한 집계**이며 Domain 간 직접적인 소유 관계를 의미하지 않는다.

즉 다음 원칙을 따른다.

> UI의 통합과 Domain의 통합은 별개의 문제로 본다.
>

---

## 9. Collection

`MemoryCollection`을 전역 Domain으로 강제하지 않는다.

여러 Record를 하나로 묶는 개념이 필요한 경우 **해당 Feature 내부에서 Collection을 설계**한다.

예를 들어 Travel Feature에서 다음과 같이 구성할 수 있다.

```
Trip

제주 여행
 │
 ├─ TravelRecord
 ├─ TravelRecord
 └─ TravelRecord
```

Movie나 Place가 동일 Collection을 공유해야 한다고 미리 가정하지 않는다.

Collection 구조는 각 Feature 설계 단계에서 실제 요구사항을 확인한 뒤 결정한다.

---

## 10. Time Capsule

Time Capsule은 서비스의 대표적인 감성 Feature 중 하나이며 독립 Domain으로 관리한다.

개인 Space와 공유 Space 모두에서 사용할 수 있어야 한다.

개념적인 Lifecycle은 다음과 같이 예상한다.

```
DRAFT
  ↓
SEALED
  ↓
OPENED
```

다만 세부 상태와 정책은 Time Capsule Feature 개발 직전 상세 설계 단계에서 확정한다.

---

## 11. 회고 및 AI

서비스에 축적된 기록을 일정 기간 또는 특정 시점에 다시 구성하여 보여주는 회고 기능을 제공하는 방향으로 한다.

예:

- 이번 달의 나
- 우리의 2027년
- 제주 여행 돌아보기
- 우리가 기록한 지 1년

AI는 새로운 경험을 만들어내는 용도가 아니라 **실제로 존재하는 사용자 기록을 바탕으로 회고를 생성하는 역할**을 한다.

AI 기능은 Feature 데이터를 직접 소유하지 않는다.

각 Domain의 데이터를 조회하여 회고용 데이터로 가공한 뒤 AI에 전달하는 형태를 고려한다.

---

## 12. Frontend Architecture

Flutter는 Clean Architecture 기반으로 개발한다.

각 Feature는 가능한 독립적인 구조를 갖는다.

```
features/

├─ space/
├─ movie/
├─ travel/
├─ bucket/
├─ capsule/
└─ ...
```

각 Feature 내부에서는 필요에 따라 다음 계층을 분리한다.

```
presentation
domain
data
```

화면은 기본적으로 다음 구조로 관리한다.

```
Screen
   ↓
ViewModel / Notifier
   ↓
State
```

상태관리에는 Riverpod을 사용한다.

`SpaceState`는 Space 화면 자체의 책임만 관리한다.

예:

```
currentSpace
widgetConfigs
loading
error
```

Movie, Bucket, Capsule 등의 상세 상태를 `SpaceState` 하나에 집중시키지 않는다.

각 Widget 또는 Feature는 자신의 ViewModel과 State를 독립적으로 가질 수 있다.

---

## 13. Backend Architecture

Spring Boot에서도 Feature 또는 Domain 경계를 유지한다.

예:

```
space
movie
travel
bucket
capsule
auth
```

각 Feature는 자신의 필요에 따라 다음 구성요소를 관리할 수 있다.

```
Controller
Service
Repository
Entity
DTO
Mapper
```

모든 Feature가 동일한 구조를 기계적으로 가져야 하는 것은 아니다.

Feature의 복잡도와 요구사항에 맞는 구조를 적용한다.

---

## 14. 공통 영역

다음 영역은 여러 Feature에서 공통으로 사용한다.

```
User
SocialAccount
Authentication
Space
SpaceMember
SpaceWidgetConfig
Invitation
Storage Infrastructure
공통 Exception
공통 API Response 정책
```

공통이라는 이유만으로 모든 Feature의 Domain Model을 하나로 합치지는 않는다.

---

## 15. 인증

다음 OIDC 기반 소셜 로그인을 지원하는 방향으로 한다.

- Google
- Kakao
- Naver

클라이언트에서 Provider 인증을 수행한 후 인증 결과를 Spring Boot에 전달한다.

Spring Boot는 Provider 인증정보를 검증하고 서비스 User를 식별한 뒤 자체 Access Token 및 Refresh Token을 발급한다.

JWT 기반 인증을 사용하는 이유 중 하나는 초기 Flutter Web뿐 아니라 향후 Android/iOS 앱에서도 동일한 Backend API를 사용할 수 있도록 하기 위함이다.

---

## 16. 현재 확정된 모델링 원칙

현재 시점에서는 다음 사항을 프로젝트의 기본 원칙으로 확정한다.

1. **Space는 모든 Feature가 존재하는 Context/Container이다.**
2. **SpaceWidgetConfig는 Dashboard UI 구성 정보이다.**
3. **Memory는 제품 개념이며 반드시 하나의 전역 Entity일 필요는 없다.**
4. **각 Widget/Feature는 독립적인 Domain으로 동작한다.**
5. **각 Domain은 자신의 데이터와 Lifecycle을 소유한다.**
6. **Feature 간 직접적인 데이터 공유 및 결합은 기본적으로 피한다.**
7. **여러 Feature 데이터를 함께 보여줘야 한다면 조회/Presentation 계층에서 집계한다.**
8. **Collection이 필요한 경우 해당 Feature 내부에서 설계한다.**
9. **UI 통합과 Domain 통합은 별개의 문제로 취급한다.**
10. **새로운 Feature의 상세 모델은 실제 Feature 개발 직전에 확정한다.**

---

## 17. 의도적으로 아직 결정하지 않는 사항

현재 단계에서는 다음 사항을 확정하지 않는다.

- Movie의 정확한 DB Schema
- Travel의 Trip 구조
- BucketItem의 정확한 상태 전이
- Time Capsule의 세부 봉인 정책
- 각 Feature의 API Endpoint
- 각 Feature의 DTO 구조
- 각 Feature별 화면 구성
- AI Prompt 구조
- Timeline 집계 방식
- 검색 방식
- 미디어 제한

해당 사항은 Feature 구현 직전 요구사항 및 상세 설계 단계에서 결정한다.

---

## 18. Feature 개발 전 설계 절차

각 Feature는 개발 직전에 별도의 Mini Spec을 작성한다.

예를 들어 Movie Feature 개발을 시작한다면 다음 항목을 먼저 정의한다.

1. 사용자가 왜 사용하는가?
2. 핵심 User Flow는 무엇인가?
3. 어떤 데이터를 기록하는가?
4. Entity는 무엇인가?
5. 상태 변화가 존재하는가?
6. 어떤 API가 필요한가?
7. Flutter State는 무엇인가?
8. 주요 예외 상황은 무엇인가?
9. 다른 Domain과 관계가 필요한가?
10. 테스트해야 할 핵심 동작은 무엇인가?

이후 다음 과정을 반복한다.

```
요구사항
    ↓
Feature Mini Spec
    ↓
구현
    ↓
발견된 문제
    ↓
Spec 수정
    ↓
리팩터링
```

---

## 19. 설계 원칙

초기 구상 단계에서 모든 Feature의 상세 구조를 미리 확정하지 않는다.

현재 단계에서는 프로젝트 전체가 흔들리지 않도록 하기 위한 **Architecture / Requirement Baseline**까지만 정의한다.

실제 Feature의 상세 구조는 해당 Feature 개발 직전 결정한다.

이를 통해 다음 문제를 방지한다.

- 아직 검증되지 않은 요구사항을 과도하게 설계하는 문제
- 실제 UI/UX 설계 이후 불필요해지는 DB 구조
- 개발 시작 전 지나친 추상화
- 아직 학습하지 않은 Spring/JPA 개념을 무리하게 적용하는 문제
- AI가 개발자의 이해 없이 구조를 대신 결정하는 문제

따라서 본 프로젝트는 **Just-in-Time Design** 방식으로 개발한다.

> 전체 서비스의 원칙은 먼저 정의하되, 각 Feature의 세부 요구사항·Domain·API·State 구조는 개발 직전에 설계한다.
>