import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../../../ui/presentation/component/app_asset_icon.dart';
import 'app_navigation_item.dart';

class AppBottomAppBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppBottomAppBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
        color: AppColors.paper,
        border: Border(top: BorderSide(color: AppColors.navigationBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          for (var index = 0; index < AppNavigationItem.values.length; index++)
            Expanded(
              child: Semantics(
                selected: index == navigationShell.currentIndex,
                button: true,
                child: InkWell(
                  onTap: () {
                    navigationShell.goBranch(index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 24,
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
                      const SizedBox(height: 4),
                      Text(
                        AppNavigationItem.values[index].label,
                        style: AppTextStyles.badge.copyWith(
                          height: 1,
                          color: index == navigationShell.currentIndex
                              ? AppColors.coralDeep
                              : AppColors.bodyText,
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
        ],
      ),
    );
  }
}
