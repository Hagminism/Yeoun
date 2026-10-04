import '../domain/model/culture_kind.dart';
import '../domain/model/culture_member.dart';
import '../domain/model/culture_review.dart';
import '../domain/model/culture_work.dart';

abstract final class CultureMockData {
  static const List<CultureMember> members = <CultureMember>[
    CultureMember(id: 'member-jiwoo', name: '지우', initials: '지'),
    CultureMember(id: 'member-junhyuk', name: '준혁', initials: '준'),
  ];

  static final List<CultureWork> works = <CultureWork>[
    CultureWork(
      id: 'culture-little-forest',
      kind: CultureKind.movie,
      title: '리틀 포레스트',
      artworkAsset: 'assets/images/home/culture_poster.jpg',
      reviews: <CultureReview>[
        CultureReview(
          memberId: 'member-jiwoo',
          memberName: '지우',
          rating: 9.5,
          review: '바쁜 날들 사이에 잠깐 멈춰 쉬어도 괜찮다고 말해주는 영화.',
          reviewedAt: DateTime(2026, 9, 21),
        ),
        CultureReview(
          memberId: 'member-junhyuk',
          memberName: '준혁',
          rating: 8.5,
          review: '계절이 바뀌는 장면마다 집밥 냄새가 나는 것 같았어.',
          reviewedAt: DateTime(2026, 9, 22),
        ),
      ],
    ),
    CultureWork(
      id: 'culture-midnight-library',
      kind: CultureKind.book,
      title: '미드나잇 라이브러리',
      reviews: <CultureReview>[
        CultureReview(
          memberId: 'member-jiwoo',
          memberName: '지우',
          rating: 8,
          review: '지금의 삶을 다시 바라보게 만든 문장들이 오래 남았다.',
          reviewedAt: DateTime(2026, 8, 30),
        ),
      ],
    ),
    CultureWork(
      id: 'culture-slow-dancing',
      kind: CultureKind.music,
      title: 'Slow Dancing',
      reviews: <CultureReview>[
        CultureReview(
          memberId: 'member-junhyuk',
          memberName: '준혁',
          rating: 9,
          review: '차 안에서 같이 듣던 밤의 공기가 떠오르는 노래.',
          reviewedAt: DateTime(2026, 8, 12),
        ),
      ],
    ),
  ];
}
