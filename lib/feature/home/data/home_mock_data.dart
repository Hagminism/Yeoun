import '../../../core/domain/model/bucket/bucket_item.dart';
import '../../../core/domain/model/capsule/time_capsule.dart';
import '../../../core/domain/model/space/anniversary.dart';
import '../../../core/domain/model/space/space_widget_config.dart';
import '../../../core/domain/model/space/space_widget_type.dart';

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
  static final widgetConfigs = [
    for (var index = 0; index < SpaceWidgetType.values.length; index++)
      SpaceWidgetConfig(
        id: SpaceWidgetType.values[index].name,
        type: SpaceWidgetType.values[index],
        position: index,
      ),
  ];
}
