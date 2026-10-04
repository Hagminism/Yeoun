import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../../../ui/presentation/component/app_card_surface.dart';

class SettingsSectionCard extends StatelessWidget {
  final String title;
  final List<Widget> rows;

  const SettingsSectionCard({
    super.key,
    required this.title,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              title,
              style: AppTextStyles.cardBody.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          AppCardSurface(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                for (var index = 0; index < rows.length; index++) ...[
                  if (index > 0)
                    const Divider(height: 1, color: AppColors.borderSoft),
                  rows[index],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
