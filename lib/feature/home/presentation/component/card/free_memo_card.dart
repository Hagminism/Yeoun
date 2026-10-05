import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../core/domain/model/memory/memo_entry.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../badge/home_badge.dart';
import '../button/home_action_button.dart';
import '../header/home_card_header.dart';

class FreeMemoCard extends StatelessWidget {
  final MemoEntry memo;
  final int count;
  final void Function() onWrite;

  const FreeMemoCard({
    super.key,
    required this.memo,
    required this.count,
    required this.onWrite,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardSurface(
      minHeight: 222,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeCardHeader(
            title: '자유 블록',
            trailing: HomeBadge(label: '$count개 메모'),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.cream,
              border: Border.all(color: AppColors.borderSoft),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        memo.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cardBody.copyWith(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      memo.dateLabel,
                      style: AppTextStyles.badge.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  memo.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cardBody.copyWith(
                    color: AppColors.bodyText,
                    height: 1.56,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          HomeActionButton(
            label: '오늘 일기 남겨볼까요?',
            trailingAsset: AppAssets.pencil3d,
            background: AppColors.surface,
            onPressed: onWrite,
          ),
        ],
      ),
    );
  }
}
