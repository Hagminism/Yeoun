import 'package:flutter/material.dart';
import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../../../ui/presentation/component/app_asset_icon.dart';
import '../bottom_app_bar/app_navigation_items.dart';

class AppNavigationRail extends StatelessWidget {
  final void Function(int) onSelected;

  const AppNavigationRail({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      decoration: const BoxDecoration(
        color: AppColors.paper,
        border: Border(right: BorderSide(color: AppColors.borderSoft)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 26),
          Text(
            '여운',
            style: AppTextStyles.cardTitle.copyWith(color: AppColors.coralDeep),
          ),
          const SizedBox(height: 30),
          for (var index = 0; index < AppNavigationItems.all.length; index++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Semantics(
                selected: index == 0,
                button: true,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    onSelected(index);
                  },
                  child: Container(
                    width: 72,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: index == 0
                          ? AppColors.coralSoft
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 24,
                          child: Center(
                            child: AppAssetIcon(
                              AppNavigationItems.all[index].asset,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          AppNavigationItems.all[index].label,
                          style: AppTextStyles.badge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
