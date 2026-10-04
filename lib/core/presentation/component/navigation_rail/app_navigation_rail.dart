import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../../../ui/presentation/component/app_asset_icon.dart';
import '../bottom_app_bar/app_navigation_item.dart';

class AppNavigationRail extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppNavigationRail({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      decoration: const BoxDecoration(
        color: AppColors.paper,
        border: Border(right: BorderSide(color: AppColors.borderSoft)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          for (var index = 0; index < AppNavigationItem.values.length; index++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Semantics(
                selected: index == navigationShell.currentIndex,
                button: true,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    navigationShell.goBranch(index);
                  },
                  child: Container(
                    width: 72,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: index == navigationShell.currentIndex
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
                              AppNavigationItem.values[index].asset,
                              tint: index == navigationShell.currentIndex
                                  ? AppColors.coralDeep
                                  : AppColors.bodyText,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          AppNavigationItem.values[index].label,
                          style: AppTextStyles.badge.copyWith(
                            color: index == navigationShell.currentIndex
                                ? AppColors.coralDeep
                                : AppColors.secondaryText,
                            fontWeight: index == navigationShell.currentIndex
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
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
