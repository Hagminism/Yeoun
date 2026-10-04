import 'package:flutter/material.dart';

import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';
import '../../../domain/model/bucket_list_category.dart';
import '../../../domain/model/bucket_list_entry.dart';

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
                    _categoryBadge(entry.category),
                    const Spacer(),
                    if (entry.dueLabel != null) _dueBadge(entry.dueLabel!),
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
                  _entryNote(entry.note!, entry.noteIcon),
                ],
                if (entry.progress != null) ...[
                  const SizedBox(height: 10),
                  _entryProgress(entry.progress!, entry.progressLabel ?? ''),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryBadge(BucketListCategory category) {
    final Color background = switch (category) {
      BucketListCategory.travel || BucketListCategory.culture => AppColors.sage,
      BucketListCategory.hobby || BucketListCategory.food => AppColors.apricot,
      BucketListCategory.daily || BucketListCategory.all => AppColors.sage,
    };
    final Color foreground = switch (category) {
      BucketListCategory.travel ||
      BucketListCategory.culture => AppColors.sageText,
      BucketListCategory.hobby ||
      BucketListCategory.food => AppColors.cultureText,
      BucketListCategory.daily || BucketListCategory.all => AppColors.sageText,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        category.label,
        style: AppTextStyles.caption.copyWith(
          color: foreground,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _dueBadge(String label) {
    final bool isCountdown = label.startsWith('D-');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: isCountdown ? AppColors.coralSoft : AppColors.cream,
        border: isCountdown ? null : Border.all(color: AppColors.borderSoft),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: isCountdown ? AppColors.coralDeep : AppColors.bodyText,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _entryNote(String note, String? icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.cream,
        border: Border.all(color: AppColors.borderSoft),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Text(icon, style: AppTextStyles.cardBody),
            const SizedBox(width: 7),
          ],
          Expanded(
            child: Text(
              note,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.small.copyWith(color: AppColors.bodyText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryProgress(double progress, String label) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              size: 14,
              color: AppColors.coralDeep,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.coralDeep,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: progress.clamp(0, 1),
            minHeight: 5,
            backgroundColor: AppColors.creamDeep,
            color: AppColors.coral,
          ),
        ),
      ],
    );
  }
}
