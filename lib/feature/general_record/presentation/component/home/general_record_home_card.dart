import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../../../domain/model/general_record.dart';
import 'preview/general_record_record_preview.dart';

class GeneralRecordHomeCard extends StatelessWidget {
  final List<GeneralRecord> records;
  final void Function() onOpen;

  const GeneralRecordHomeCard({
    super.key,
    required this.records,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final recentRecords = records.toList(growable: false)
      ..sort(
        (GeneralRecord first, GeneralRecord second) =>
            second.recordedAt.compareTo(first.recordedAt),
      );
    final visibleRecords = recentRecords.take(3).toList(growable: false);

    return AppCardSurface(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(AppAssets.sparkle3d, width: 24, height: 24),
                const SizedBox(width: 8),
                Expanded(child: Text('일기장', style: AppTextStyles.cardTitle)),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
            const SizedBox(height: 13),
            if (visibleRecords.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 17,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '오늘의 기억을 한 줄부터 남겨보세요.',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
              )
            else
              Column(
                children: [
                  for (
                    var index = 0;
                    index < visibleRecords.length;
                    index++
                  ) ...[
                    GeneralRecordRecordPreview(
                      record: visibleRecords[index],
                      formattedDate: _formatDate(
                        visibleRecords[index].recordedAt,
                      ),
                    ),
                    if (index < visibleRecords.length - 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(height: 1, color: AppColors.borderSoft),
                      ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
}
