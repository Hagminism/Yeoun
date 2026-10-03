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
      SpaceWidgetType.memory => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final memory in state.memories) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                memory.imageAsset,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                semanticLabel: memory.title,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(memory.title),
              subtitle: Text(memory.subtitle),
            ),
          ],
        ],
      ),
      SpaceWidgetType.memo => Text(
        state.memo.content,
        style: AppTextStyles.body,
      ),
      SpaceWidgetType.culture => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            state.culture.posterAsset,
            height: 180,
            semanticLabel: state.culture.title,
          ),
          const SizedBox(height: 16),
          Text(state.culture.title, style: AppTextStyles.cardTitle),
          const SizedBox(height: 8),
          Text(
            '⭐ ${state.culture.rating.toStringAsFixed(1)}',
            style: AppTextStyles.body,
          ),
          Text(state.culture.review, style: AppTextStyles.small),
        ],
      ),
    };
  }
}
