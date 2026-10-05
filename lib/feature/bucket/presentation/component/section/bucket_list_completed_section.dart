import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../../../domain/model/bucket_list_entry.dart';
import 'completed_entry/bucket_list_completed_entry.dart';

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
                    BucketListCompletedEntry(
                      entry: entries[index],
                      onToggle: onToggle,
                    ),
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
}
