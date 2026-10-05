import 'package:flutter/material.dart';

import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';
import '../../../domain/model/bucket_list_category.dart';
import '../../../domain/model/bucket_list_entry.dart';
import 'entry/bucket_list_entry_note.dart';
import 'entry/bucket_list_entry_progress.dart';

class BucketListEntryCard extends StatelessWidget {
  final BucketListEntry entry;
  final void Function() onToggle;

  const BucketListEntryCard({
    super.key,
    required this.entry,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final Color categoryBackground = switch (entry.category) {
      BucketListCategory.travel || BucketListCategory.culture => AppColors.sage,
      BucketListCategory.hobby || BucketListCategory.food => AppColors.apricot,
      BucketListCategory.daily || BucketListCategory.all => AppColors.sage,
    };
    final Color categoryForeground = switch (entry.category) {
      BucketListCategory.travel ||
      BucketListCategory.culture => AppColors.sageText,
      BucketListCategory.hobby ||
      BucketListCategory.food => AppColors.cultureText,
      BucketListCategory.daily || BucketListCategory.all => AppColors.sageText,
    };
    final String dueLabel = entry.dueLabel ?? '';
    final bool dueLabelIsCountdown = dueLabel.startsWith('D-');

    return AppCardSurface(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Semantics(
              label: entry.completed ? '완료 취소' : '버킷 완료 처리',
              button: true,
              child: InkWell(
                onTap: onToggle,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: entry.completed ? AppColors.coral : AppColors.cream,
                    border: Border.all(color: AppColors.ink),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: entry.completed
                      ? const Padding(
                          padding: EdgeInsets.all(4),
                          child: AppAssetIcon(AppAssets.check),
                        )
                      : null,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: categoryBackground,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        entry.category.label,
                        style: AppTextStyles.caption.copyWith(
                          color: categoryForeground,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (entry.dueLabel != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: dueLabelIsCountdown
                              ? AppColors.coralSoft
                              : AppColors.cream,
                          border: dueLabelIsCountdown
                              ? null
                              : Border.all(color: AppColors.borderSoft),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          dueLabel,
                          style: AppTextStyles.caption.copyWith(
                            color: dueLabelIsCountdown
                                ? AppColors.coralDeep
                                : AppColors.bodyText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    if (entry.dueLabel == null)
                      Flexible(
                        child: Text(
                          entry.createdLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.bodyText,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  entry.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 15.5),
                ),
                if (entry.description.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(entry.description, style: AppTextStyles.small),
                ],
                if (entry.note != null && entry.progress == null) ...[
                  const SizedBox(height: 9),
                  BucketListEntryNote(note: entry.note!, icon: entry.noteIcon),
                ],
                if (entry.progress != null) ...[
                  const SizedBox(height: 10),
                  BucketListEntryProgress(
                    progress: entry.progress!,
                    label: entry.progressLabel ?? '',
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
