import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../core/domain/model/bucket/bucket_item.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../badge/home_badge.dart';
import '../button/home_action_button.dart';
import '../header/home_card_header.dart';
import '../list_item/bucket_summary_item.dart';

class BucketEntryCard extends StatelessWidget {
  final List<BucketItem> items;
  final void Function(String) onToggle;
  final void Function() onAdd;

  const BucketEntryCard({
    super.key,
    required this.items,
    required this.onToggle,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardSurface(
      minHeight: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeCardHeader(
            title: '버킷리스트',
            trailing: HomeBadge(
              label: '${items.where((item) => !item.completed).length}개 진행 중',
              background: AppColors.sageBorder,
              foreground: AppColors.sageText,
            ),
          ),
          const SizedBox(height: 12),
          for (var index = 0; index < items.take(2).length; index++) ...[
            if (index > 0) const SizedBox(height: 8),
            BucketSummaryItem(item: items[index], onToggle: onToggle),
          ],
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cream.withValues(alpha: .6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '✨ 적어두면 전부 현실이 될 거예요',
              textAlign: TextAlign.center,
              style: AppTextStyles.small,
            ),
          ),
          const SizedBox(height: 12),
          HomeActionButton(
            label: '새 버킷 추가하기',
            asset: AppAssets.addCircle,
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}
