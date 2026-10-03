# 여운(Yeoun) 세부 개발 태스크

> 기준 문서: [PRD](PRD.md), [요구사항 분석](requirements.md), [기술 스택](tech_stack.md)
>
> MVP의 목표는 PRD §24의 로그인, Space, Widget, 기본 기록, 초대, Time Capsule 흐름을 end-to-end로 완성하는 것이다. 각 Feature의 상세 설계는 구현 직전에 Mini Spec으로 확정한다.

## 진행 원칙

- MVP 필수 흐름부터 구현하고 선택 Feature는 MVP 완료 후 우선순위를 정한다.
- 각 Feature 착수 전에 사용자 목적, 핵심 Flow, 데이터, Lifecycle, API, Flutter State, 예외 상황, 테스트 항목을 Mini Spec에 기록한다.
- 아직 결정되지 않은 Schema, Endpoint, DTO, 화면, 미디어 제한은 해당 Feature의 Mini Spec 단계에서 결정한다.
- Feature별 데이터와 Lifecycle을 분리하고, Space 소속과 사용자 권한을 서버에서 검증한다.
- 채팅, 음성·영상 통화, 공개 Feed, Follow 기능은 제품 범위에 포함하지 않는다.

## 1. 프로젝트 기반

- [ ] 기존 Flutter 프로젝트 구조와 실행 환경을 확인하고 Flutter Web에서 앱을 실행한다.
- [ ] Flutter 화면·라우팅 구조를 정리하고 go_router, Riverpod 기반의 기본 앱 구성을 마련한다.
- [ ] Spring Boot Backend 모듈을 구성하고 로컬에서 실행할 수 있도록 한다.
- [ ] Backend 패키지를 `auth`, `space`, MVP 기록 Feature, `invitation`, `capsule` 경계로 구성한다.
- [ ] Supabase PostgreSQL 연결과 DB migration 실행 방식을 구성한다.
- [ ] Supabase Storage 연동을 위한 설정을 구성하고 비밀 값은 환경 설정으로 주입한다.
- [ ] 공통 API 응답·오류 규칙과 인증이 필요한 API의 기본 처리 방식을 정한다.
- [ ] 로컬 실행에 필요한 환경 변수와 Flutter·Backend 실행 방법을 문서화한다.

## 2. 인증

**관련 기준:** PRD §17, §24.1 Flow A / 요구사항 §15

- [ ] 인증 Mini Spec에서 MVP 소셜 로그인 Provider와 Web 로그인·콜백 흐름을 확정한다.
- [ ] Flutter에서 선택한 Provider 로그인을 시작하고 ID Token을 Backend에 전달한다.
- [ ] Backend에서 Provider의 OIDC 인증정보와 ID Token을 검증한다.
- [ ] 검증된 계정으로 서비스 User를 조회하거나 생성하고 SocialAccount를 연결한다.
- [ ] Backend Access Token·Refresh Token 발급 및 Refresh 흐름을 구현한다.
- [ ] Flutter에서 세션 복원, 로그인 상태 유지, 로그아웃, 만료된 세션 처리를 구현한다.
- [ ] 인증 상태에 따른 라우트 보호와 로그인 후 원래 진입 경로 복귀를 구현한다.
- [ ] 유효하지 않거나 만료된 Token, Provider 검증 실패, 계정 조회 실패를 처리한다.
- [ ] 인증 성공·실패·토큰 갱신 흐름을 검증하는 테스트를 작성한다.

## 3. Space

**관련 기준:** PRD §7, §24.1 Flow B / 요구사항 §3, §14

- [ ] Space Mini Spec에서 최초 Space 생성 방식, 개인·공유 Space의 MVP 범위, 멤버 권한을 확정한다.
- [ ] User, SocialAccount, Space, SpaceMember의 최소 데이터 구조와 관계를 설계한다.
- [ ] Space 및 멤버십 데이터의 DB migration을 추가한다.
- [ ] Space 생성, 사용자가 참여한 Space 목록 조회, Space 상세 조회 API를 구현한다.
- [ ] Space 생성자와 멤버십을 설정하고 Space별 데이터 경계를 서버에서 검증한다.
- [ ] 로그인 후 Space가 없는 사용자와 이미 Space가 있는 사용자의 진입 흐름을 구현한다.
- [ ] Space 목록·생성·선택 화면과 현재 Space 전환을 구현한다.
- [ ] Space 로딩, 빈 상태, 접근 거부, 서버 오류 상태를 화면에 반영한다.
- [ ] 비멤버의 Space 접근 및 다른 Space 데이터 조회가 차단되는지 검증한다.

## 4. Space Dashboard와 Widget

**관련 기준:** PRD §8–9, §24.1 Flow C / 요구사항 §4–5

- [ ] Widget Mini Spec에서 MVP Widget 종류, 기본 구성, 추가·숨김·정렬 규칙을 확정한다.
- [ ] SpaceWidgetConfig의 `spaceId`, `type`, `position`, `visible` 구조와 제약을 설계한다.
- [ ] SpaceWidgetConfig DB migration 및 Space 소속 검증을 추가한다.
- [ ] 현재 Space의 Widget 목록을 `position` 순으로 반환하는 API를 구현한다.
- [ ] Widget 추가, 표시·숨김 변경, 순서 변경을 저장하는 API를 구현한다.
- [ ] 허용되지 않은 Widget Type과 다른 Space의 설정 변경 요청을 거부한다.
- [ ] Flutter에서 SpaceWidgetConfig를 실제 Widget으로 연결하는 공통 Wrapper를 구현한다.
- [ ] MVP Widget 추가·숨김·순서 변경 UI를 구현하고 변경 결과를 서버에 저장한다.
- [ ] 재접속 또는 Space 재진입 후 저장된 Widget 구성과 순서를 복원한다.
- [ ] Widget 추가·변경·복원 및 권한 검증 흐름을 테스트한다.

## 5. 기본 기록 Feature

**관련 기준:** PRD §13.1, §24.1 Flow D, §25 / 요구사항 §6–8

- [ ] 기본 기록 Mini Spec에서 기록 필드, 사진 첨부 범위, 편집·삭제 Lifecycle을 확정한다.
- [ ] 기본 기록을 독립 Feature로 설계하고 다른 Feature의 Domain 데이터와 분리한다.
- [ ] Space 소속 기록의 생성·목록·상세·수정·삭제 API를 구현한다.
- [ ] 모든 기록 API에서 Space 멤버십과 기록 소속 Space를 검증한다.
- [ ] 사진과 짧은 글을 기록하고, Storage에 사진을 업로드·조회하며 DB에 경로·Metadata를 저장한다.
- [ ] 기록 목록, 상세, 작성·수정 화면과 입력 검증을 구현한다.
- [ ] 삭제 시 기록과 연결된 미디어의 정리 정책을 Mini Spec에 정하고 구현한다.
- [ ] 기본 기록 Widget에서 기록 Feature로 진입하고 필요한 요약 정보를 표시한다.
- [ ] 기록 CRUD, Space 격리, 사진 접근 권한을 검증하는 테스트를 작성한다.

## 6. Space 초대

**관련 기준:** PRD §18, §24.1 Flow E / 요구사항 §14

- [ ] 초대 Mini Spec에서 링크 유효 기간, 취소·재사용 정책, 초대 권한을 확정한다.
- [ ] Invitation의 최소 데이터와 안전한 초대 Token 검증 방식을 설계한다.
- [ ] 초대 링크 생성과 로그인 사용자의 Space 참여 API를 구현한다.
- [ ] 만료·취소·잘못된 초대와 이미 참여 중인 사용자를 처리한다.
- [ ] Space 화면에서 초대 링크 생성·복사·공유 흐름을 구현한다.
- [ ] 초대 링크 진입 정보를 로그인 완료까지 보존하고 로그인 후 초대 수락으로 이어준다.
- [ ] 초대 수락 후 참여한 Space로 이동하고 Space 목록을 갱신한다.
- [ ] 다른 Space에 대한 초대 생성 권한과 초대 수락 경계를 검증한다.
- [ ] 초대 생성부터 로그인 및 Space 참여까지의 통합 흐름을 테스트한다.

## 7. Time Capsule

**관련 기준:** PRD §14, §24.1 Flow F, §25 / 요구사항 §10

- [ ] Capsule Mini Spec에서 개인·공유 범위, 공개 시점, 봉인 후 수정 가능 여부, 상태 전이를 확정한다.
- [ ] MVP Lifecycle과 시간대·공개 시점 경계 처리를 정의한다.
- [ ] Time Capsule 데이터와 Space·작성자·참여자 관계를 설계하고 DB migration을 추가한다.
- [ ] Capsule 생성, 목록·상세 조회, 초안 수정, 봉인 API를 구현한다.
- [ ] 공개 시각 전에는 Capsule 내용이 노출되지 않고 공개 시각 이후에만 열리도록 서버에서 검증한다.
- [ ] DRAFT, SEALED, OPENED 상태에 맞는 Flutter 목록·작성·상세 화면을 구현한다.
- [ ] 공개 전 잠금 상태와 공개 후 열람 상태를 구분해 표시한다.
- [ ] Space 멤버십 및 개인·공유 Capsule 접근 권한을 검증한다.
- [ ] 공개 시각 전후, 상태 전이, 권한 경계를 검증하는 테스트를 작성한다.

## 8. 앱 연결과 사용성

- [ ] 로그인 후 Space 선택, Dashboard 진입, 각 Widget의 Feature 이동 경로를 연결한다.
- [ ] 로그인 전 초대 링크 진입부터 초대 수락까지 라우팅 상태를 유지한다.
- [ ] 주요 Flow에서 로딩·빈 상태·오류·재시도 UI를 일관되게 제공한다.
- [ ] 모바일 우선 Web 화면이 작은 화면과 데스크톱 브라우저에서 동작하도록 확인한다.
- [ ] 브라우저 새로고침 후 로그인 세션, 현재 Space, Widget 구성이 복원되는지 확인한다.

## 9. MVP 통합 검증과 배포

- [ ] Flow A: 소셜 로그인 후 서비스 User가 생성 또는 조회되는지 검증한다.
- [ ] Flow B: Space 생성·진입·재접속이 가능한지 검증한다.
- [ ] Flow C: Widget 추가·배치·저장 후 동일한 구성이 복원되는지 검증한다.
- [ ] Flow D: 기본 기록을 생성·조회·수정·삭제할 수 있는지 검증한다.
- [ ] Flow E: 초대 링크로 로그인한 사용자가 대상 Space에 참여하는지 검증한다.
- [ ] Flow F: Time Capsule을 생성·봉인하고 지정 시점 이후 열람할 수 있는지 검증한다.
- [ ] 인증되지 않은 요청, 비멤버 요청, 다른 Space ID를 사용한 접근이 거부되는지 검증한다.
- [ ] Flutter Web 및 Spring Boot 배포 환경을 선정하고 환경별 설정을 분리한다.
- [ ] Supabase PostgreSQL·Storage 연결, DB migration, 서비스 도메인과 API 주소를 배포 환경에 설정한다.
- [ ] 배포된 Web 앱에서 로그인부터 핵심 MVP Flow까지 최종 점검한다.

## MVP 이후 후보

아래 항목은 MVP 필수 범위가 아니며, 착수 전에 우선순위와 각 Feature Mini Spec을 정한다.

- [ ] Movie / Culture 기록 Feature
- [ ] Place 방문 기록 Feature
- [ ] Bucket List Feature
- [ ] Travel 및 여행 내부 기록 Collection
- [ ] 과거의 오늘·첫 기록·기념일 회고 등 Memory 재발견
- [ ] 월간·연간·여행 회고 등 AI 기능과 장애 시 일반 기능의 독립 동작
- [ ] 댓글·Reaction·공동 작성 등 기록 관련 상호작용
- [ ] Timeline 집계와 검색 기능
