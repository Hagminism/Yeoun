import 'package:flutter/material.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';

class HomeCardHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final bool capsule;
  final String? iconAsset;

  const HomeCardHeader({
    super.key,
    required this.title,
    this.trailing,
    this.capsule = false,
    this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (capsule)
          Image.asset(AppAssets.hourglass3d, width: 24, height: 24)
        else if (iconAsset != null)
          Image.asset(iconAsset!, width: 24, height: 24)
        else
          const AppAssetIcon(AppAssets.list),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.cardTitle,
          ),
        ),
        ?trailing,
      ],
    );
  }
}
