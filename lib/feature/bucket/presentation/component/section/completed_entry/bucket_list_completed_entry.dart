import 'package:flutter/material.dart';

import '../../../../../../ui/app_assets.dart';
import '../../../../../../ui/app_colors.dart';
import '../../../../../../ui/app_text_styles.dart';
import '../../../../../../ui/presentation/component/app_asset_icon.dart';
import '../../../../domain/model/bucket_list_entry.dart';

class BucketListCompletedEntry extends StatelessWidget {
  final BucketListEntry entry;
  final void Function(String entryId) onToggle;

  const BucketListCompletedEntry({
    super.key,
    required this.entry,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cream,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderSoft),
      ),
      child: InkWell(
        onTap: () => onToggle(entry.id),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.coral,
                  border: Border.all(color: AppColors.ink),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const AppAssetIcon(AppAssets.check),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.cardBody.copyWith(
                        color: AppColors.secondaryText,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      entry.completedAt ?? '완료',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.bodyText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.bodyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
