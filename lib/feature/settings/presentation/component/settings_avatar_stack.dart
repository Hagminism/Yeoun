import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';

class SettingsAvatarStack extends StatelessWidget {
  const SettingsAvatarStack({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 30,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/settings/partner_avatar_1.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/settings/partner_avatar_2.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
