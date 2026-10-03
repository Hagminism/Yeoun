import 'package:flutter/material.dart';
import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../../../ui/presentation/component/app_asset_icon.dart';
import 'app_navigation_items.dart';

class AppBottomAppBar extends StatelessWidget {
  final void Function(int) onSelected;

  const AppBottomAppBar({super.key, required this.onSelected});

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
          for (var index = 0; index < AppNavigationItems.all.length; index++)
            Expanded(
              child: Semantics(
                selected: index == 0,
                button: true,
                child: InkWell(
                  onTap: () {
                    onSelected(index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Center(
                          child: AppAssetIcon(
                            AppNavigationItems.all[index].asset,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppNavigationItems.all[index].label,
                        style: AppTextStyles.badge.copyWith(
                          height: 1,
                          color: index == 0
                              ? AppColors.coralDeep
                              : AppColors.bodyText,
                          fontWeight: index == 0
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
