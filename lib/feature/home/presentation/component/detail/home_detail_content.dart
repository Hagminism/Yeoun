import 'package:flutter/material.dart';
import '../../../../../core/domain/model/space/space_widget_type.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../screen/home_state.dart';

class HomeDetailContent extends StatelessWidget {
  final SpaceWidgetType type;
  final HomeState state;

  const HomeDetailContent({super.key, required this.type, required this.state});

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      SpaceWidgetType.anniversary => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(state.anniversary.startLabel, style: AppTextStyles.cardTitle),
          const SizedBox(height: 12),
          Text(
            '함께한 ${state.anniversary.daysTogether}일\n${state.anniversary.targetLabel} D-${state.anniversary.remainingDays}',
            style: AppTextStyles.body,
          ),
        ],
      ),
      SpaceWidgetType.bucket => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final item in state.buckets)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                item.completed
                    ? Icons.check_circle_outline
                    : Icons.circle_outlined,
              ),
              title: Text(item.title, style: AppTextStyles.cardBody),
              subtitle: Text(item.category),
            ),
        ],
      ),
      SpaceWidgetType.capsule => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lock_outline),
          const SizedBox(height: 12),
          Text(state.capsule.title, style: AppTextStyles.cardTitle),
          const SizedBox(height: 8),
          Text(state.capsule.authors, style: AppTextStyles.small),
          const SizedBox(height: 16),
          Text(state.capsule.openingLabel, style: AppTextStyles.body),
        ],
      ),
      SpaceWidgetType.generalRecord ||
      SpaceWidgetType.culture => const SizedBox.shrink(),
    };
  }
}
