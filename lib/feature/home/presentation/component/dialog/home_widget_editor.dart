import 'package:flutter/material.dart';
import '../../../../../core/domain/model/space/space_widget_config.dart';
import '../../../../../ui/app_text_styles.dart';

class HomeWidgetEditor extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('위젯 추가 및 순서 편집', style: AppTextStyles.cardTitle),
                ),
                IconButton(
                  tooltip: '편집 닫기',
                  onPressed: onClose,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ReorderableListView.builder(
                shrinkWrap: true,
                buildDefaultDragHandles: false,
                itemCount: configs.length,
                onReorderItem: onReorder,
                itemBuilder: (BuildContext context, int index) {
                  final config = configs[index];
                  return ListTile(
                    key: ValueKey(config.id),
                    leading: ReorderableDragStartListener(
                      index: index,
                      child: const Tooltip(
                        message: '드래그해서 순서 변경',
                        child: Icon(Icons.drag_handle),
                      ),
                    ),
                    title: Text(
                      config.type.label,
                      style: AppTextStyles.cardBody,
                    ),
                    trailing: Switch(
                      value: config.visible,
                      onChanged: (bool value) {
                        onVisibilityChanged(config.id, value);
                      },
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
