import 'package:flutter/material.dart';
import 'package:yeoun/ui/app_assets.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../../../ui/presentation/component/app_card_surface.dart';

class SettingsQuickAction extends StatelessWidget {
  final void Function() onPressed;

  const SettingsQuickAction({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppCardSurface(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      radius: 16,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.lightbulb3d, width: 24, height: 24),
                const SizedBox(height: 2),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '기능 요청하기',
                style: AppTextStyles.cardBody.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: AppColors.secondaryText,
            ),
          ],
        ),
      ),
    );
  }
}
