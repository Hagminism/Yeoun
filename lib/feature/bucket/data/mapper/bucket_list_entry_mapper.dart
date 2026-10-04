import '../../../../core/domain/model/bucket/bucket_item.dart';
import '../../domain/model/bucket_list_category.dart';
import '../../domain/model/bucket_list_entry.dart';

abstract final class BucketListEntryMapper {
  static List<BucketListEntry> fromHomeItems(List<BucketItem> items) {
    return [
      for (final item in items)
        BucketListEntry(
          id: item.id,
          title: item.title,
          category: _categoryFrom(item.category),
          completed: item.completed,
          description: _descriptionFor(item.id),
          createdLabel: _createdLabelFor(item.id),
          dueLabel: _dueLabelFor(item.id),
          note: _noteFor(item.id, item.completed),
          noteIcon: _noteIconFor(item.id, item.completed),
          progress: item.id == 'bucket-2' ? .67 : null,
          progressLabel: item.id == 'bucket-2' ? '24/36장' : null,
          completedAt: item.completed ? '05.12 완료' : null,
        ),
    ];
  }

  static BucketListCategory _categoryFrom(String value) {
    if (value.contains('여행')) return BucketListCategory.travel;
    if (value.contains('취미')) return BucketListCategory.hobby;
    if (value.contains('문화')) return BucketListCategory.culture;
    if (value.contains('맛집')) return BucketListCategory.food;
    return BucketListCategory.daily;
  }

  static String _descriptionFor(String id) {
    return switch (id) {
      'bucket-1' => '함께 준비하고 있는 우리만의 여행',
      'bucket-2' => '을지로 현상소에서 스캔본을 받고 카페에서 같이 확인하기',
      'bucket-3' => '좋아하는 공연을 골라 함께 관람하기',
      'bucket-4' => '새로운 동네를 걸으며 마음에 드는 장소를 찾아보기',
      _ => '',
    };
  }

  static String _createdLabelFor(String id) {
    return switch (id) {
      'bucket-2' => '3일 전 추가됨',
      'bucket-3' => '5일 전 추가됨',
      'bucket-4' => '1주 전 추가됨',
      _ => '방금 전',
    };
  }

  static String? _dueLabelFor(String id) {
    return switch (id) {
      'bucket-1' => 'D-42',
      'bucket-5' => '함께 만들기',
      _ => null,
    };
  }

  static String? _noteFor(String id, bool completed) {
    if (completed) return '기억 조각에 기록했어요';
    return switch (id) {
      'bucket-1' => '지우와 함께 기획 중 · 렌트카 예약 완료',
      'bucket-2' => '필름 24장을 촬영했어요',
      'bucket-3' => '공연 후보를 함께 골라보세요',
      'bucket-4' => '가고 싶은 장소를 모으고 있어요',
      'bucket-5' => '함께 들을 곡을 모아보세요',
      _ => null,
    };
  }

  static String? _noteIconFor(String id, bool completed) {
    if (completed) return '✦';
    return switch (id) {
      'bucket-1' => '🚗',
      'bucket-2' => '📷',
      'bucket-3' => '♫',
      'bucket-4' => '⌖',
      'bucket-5' => '♫',
      _ => null,
    };
  }
}
