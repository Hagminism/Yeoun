import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';
import '../../../domain/model/bucket_list_entry.dart';

class BucketListCompletedSection extends StatelessWidget {
  final List<BucketListEntry> entries;
  final bool expanded;
  final void Function(bool) onExpandedChanged;
  final void Function(String) onToggle;

  const BucketListCompletedSection({
    super.key,
    required this.entries,
    required this.expanded,
    required this.onExpandedChanged,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Semantics(
            button: true,
            expanded: expanded,
            label: '달성한 기억 ${entries.length}개',
            child: InkWell(
              onTap: () {
                onExpandedChanged(!expanded);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    const Icon(
                      Icons.view_headline,
                      size: 22,
                      color: AppColors.ink,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('달성한 기억', style: AppTextStyles.cardTitle),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        border: Border.all(color: AppColors.borderSoft),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '${entries.length}개 달성',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.bodyText,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 22,
                      color: AppColors.bodyText,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedCrossFade(
            crossFadeState: expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 180),
            firstChild: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  for (var index = 0; index < entries.length; index++) ...[
                    _completedEntry(entries[index]),
                    if (index != entries.length - 1) const SizedBox(height: 9),
                  ],
                ],
              ),
            ),
            secondChild: const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }

  Widget _completedEntry(BucketListEntry entry) {
    return Material(
      color: AppColors.cream,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderSoft),
      ),
      child: InkWell(
        onTap: () {
          onToggle(entry.id);
        },
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
