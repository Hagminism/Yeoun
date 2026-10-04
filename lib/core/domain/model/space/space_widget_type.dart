import 'space_widget_category.dart';

enum SpaceWidgetType {
  anniversary('기념일', SpaceWidgetCategory.couple),
  capsule('타임캡슐', SpaceWidgetCategory.common),
  bucket('버킷리스트', SpaceWidgetCategory.common),
  generalRecord('일반 기록', SpaceWidgetCategory.common),
  culture('문화', SpaceWidgetCategory.common);

  final String label;
  final SpaceWidgetCategory category;

  const SpaceWidgetType(this.label, this.category);
}
