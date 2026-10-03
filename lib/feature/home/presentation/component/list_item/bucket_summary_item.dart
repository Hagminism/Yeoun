import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';

import '../../../../../core/domain/model/bucket/bucket_item.dart';

class BucketSummaryItem extends StatelessWidget {
  final BucketItem item;
  final void Function(String) onToggle;

  const BucketSummaryItem({
    super.key,
    required this.item,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: item.title,
      checked: item.completed,
      child: Material(
        color: AppColors.cream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.borderSoft),
        ),
        child: InkWell(
          onTap: () {
            onToggle(item.id);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            constraints: const BoxConstraints(minHeight: 42),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: item.completed
                        ? AppColors.checkedBackground
                        : AppColors.mutedSurface,
                    borderRadius: BorderRadius.circular(4),
                    border: item.completed
                        ? null
                        : Border.all(
                            color: AppColors.ink.withValues(alpha: .2),
                          ),
                  ),
                  child: item.completed
                      ? const Center(child: AppAssetIcon(AppAssets.check))
                      : null,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cardBody,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  item.category,
                  style: AppTextStyles.small.copyWith(height: 1.33),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
