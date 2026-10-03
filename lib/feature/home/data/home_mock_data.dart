import '../../../core/domain/model/bucket/bucket_item.dart';
import '../../../core/domain/model/capsule/time_capsule.dart';
import '../../../core/domain/model/culture/culture_record.dart';
import '../../../core/domain/model/memory/memory_entry.dart';
import '../../../core/domain/model/memory/memo_entry.dart';
import '../../../core/domain/model/space/anniversary.dart';
import '../../../core/domain/model/space/space_widget_config.dart';
import '../../../core/domain/model/space/space_widget_type.dart';
import '../../../ui/app_assets.dart';

abstract final class HomeMockData {
  // Figma에 표시된 시점을 재현하는 샘플이며 서버 데이터와 분리한다.
  static const anniversary = Anniversary(
    startLabel: '2023.05.12 ~',
    daysTogether: 354,
    targetLabel: '1주년 (365일)까지',
    remainingDays: 11,
    progress: .97,
  );
  static const capsule = TimeCapsule(
    title: '1주년에 열어볼 서로의 편지',
    authors: '지우 & 준혁이 작성 완료 (음성메시지 1개 포함)',
    openingLabel: '2024년 5월 12일 00:00 오픈 예정',
    remainingDays: 11,
  );
  static const buckets = [
    BucketItem(
      id: 'bucket-1',
      title: '여름 제주도 노을 보며 차박하기',
      category: '🏝️ 여행',
      completed: true,
    ),
    BucketItem(id: 'bucket-2', title: '필름 카메라로 서로의 사계절 남기기', category: '📸 취미'),
    BucketItem(id: 'bucket-3', title: '함께 좋아하는 공연 보러 가기', category: '🎵 문화'),
    BucketItem(id: 'bucket-4', title: '새로운 동네에서 하루 보내기', category: '🏝️ 여행'),
    BucketItem(id: 'bucket-5', title: '우리만의 플레이리스트 만들기', category: '📸 취미'),
  ];
  static const memories = [
    MemoryEntry(
      id: 'memory-1',
      title: '성수동 주말 데이트',
      subtitle: '3일 전 · 지우',
      imageAsset: AppAssets.albumDate,
    ),
    MemoryEntry(
      id: 'memory-2',
      title: '석촌호수 벚꽃 산책',
      subtitle: '1주 전 · 준혁',
      imageAsset: AppAssets.albumWalk,
    ),
  ];
  static const memo = MemoEntry(
    title: '비 오는 날 나눈 이야기 ☕',
    content: '서로 좋아하는 음악 플레이리스트 교환한 날. 다음 여행 때 들을 곡들 플레이리스트에 전부 담아뒀어!',
    dateLabel: '어제',
  );
  static const culture = CultureRecord(
    title: '라라랜드 (La La Land)',
    rating: 5,
    review: '엔딩 씬에서 서로 눈 마주친 순간',
    posterAsset: AppAssets.culturePoster,
  );
  static final widgetConfigs = [
    for (var index = 0; index < SpaceWidgetType.values.length; index++)
      SpaceWidgetConfig(
        id: SpaceWidgetType.values[index].name,
        type: SpaceWidgetType.values[index],
        position: index,
      ),
  ];
}
