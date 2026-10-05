import 'package:flutter/material.dart';

import '../../../../../../ui/app_assets.dart';
import '../../../../../../ui/app_text_styles.dart';
import '../../../../../../ui/presentation/component/app_asset_icon.dart';

class GeneralRecordDateLabel extends StatelessWidget {
  final DateTime date;

  const GeneralRecordDateLabel({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const AppAssetIcon(AppAssets.calendar3d, width: 16, height: 16),
            const SizedBox(width: 6),
            Text(
              '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}',
              style: AppTextStyles.caption,
            ),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
