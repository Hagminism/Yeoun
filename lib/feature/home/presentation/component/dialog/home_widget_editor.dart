import 'package:flutter/material.dart';
import '../../../../../core/domain/model/space/space_widget_category.dart';
import '../../../../../core/domain/model/space/space_widget_config.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import 'filter/home_widget_category_filter.dart';
import 'home_widget_toggle.dart';

class HomeWidgetEditor extends StatefulWidget {
  final List<SpaceWidgetConfig> configs;
  final void Function(String, bool) onVisibilityChanged;
  final void Function(int, int) onReorder;
  final void Function() onClose;

  const HomeWidgetEditor({
    super.key,
    required this.configs,
    required this.onVisibilityChanged,
    required this.onReorder,
    required this.onClose,
  });

  @override
  State<HomeWidgetEditor> createState() => _HomeWidgetEditorState();
}

class _HomeWidgetEditorState extends State<HomeWidgetEditor> {
  SpaceWidgetCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final visibleConfigs = widget.configs
        .where(
          (SpaceWidgetConfig config) =>
              _selectedCategory == null ||
              config.type.category == _selectedCategory,
        )
        .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('위젯 배치 관리', style: AppTextStyles.cardTitle),
                ),
                IconButton(
                  tooltip: '편집 닫기',
                  onPressed: widget.onClose,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            HomeWidgetCategoryFilter(
              selectedCategory: _selectedCategory,
              onChanged: (SpaceWidgetCategory? category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _selectedCategory == null
                    ? '모든 위젯은 사용 형태와 관계없이 추가할 수 있어요.'
                    : '${_selectedCategory!.label} 위젯',
                style: AppTextStyles.caption,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: visibleConfigs.isEmpty
                  ? Center(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.cream,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderSoft),
                        ),
                        child: Text(
                          '아직 이 분류에 등록된 위젯이 없어요.\n새 위젯이 추가되면 여기서 확인할 수 있어요.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.small,
                        ),
                      ),
                    )
                  : ReorderableListView.builder(
                      shrinkWrap: true,
                      buildDefaultDragHandles: false,
                      itemCount: visibleConfigs.length,
                      onReorderItem: (int from, int to) {
                        if (_selectedCategory == null) {
                          widget.onReorder(from, to);
                        }
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final config = visibleConfigs[index];
                        return Padding(
                          key: ValueKey(config.id),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              if (_selectedCategory == null)
                                ReorderableDragStartListener(
                                  index: index,
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Tooltip(
                                      message: '드래그해서 순서 변경',
                                      child: Icon(Icons.drag_handle),
                                    ),
                                  ),
                                )
                              else
                                const SizedBox(width: 32),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      config.type.label,
                                      style: AppTextStyles.cardBody,
                                    ),
                                    Text(
                                      config.type.category.label,
                                      style: AppTextStyles.caption,
                                    ),
                                  ],
                                ),
                              ),
                              HomeWidgetToggle(
                                value: config.visible,
                                label: '${config.type.label} 위젯 표시',
                                onChanged: (bool value) {
                                  widget.onVisibilityChanged(config.id, value);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
