import 'package:flutter/material.dart';

import '../../../../../ui/app_assets.dart';

class HomeBucketCategoryLabel extends StatelessWidget {
  final String category;
  final TextStyle? style;

  const HomeBucketCategoryLabel({
    super.key,
    required this.category,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final String? iconAsset = switch (category) {
      final String value when value.contains('여행') => AppAssets.palmIsland3d,
      final String value when value.contains('취미') => AppAssets.camera3d,
      final String value when value.contains('문화') =>
        AppAssets.linkedEighthNotes3d,
      _ => null,
    };
    final String label = iconAsset == null
        ? category
        : category.replaceFirst(RegExp(r'^\S+\s+'), '');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconAsset != null) ...[
          Image.asset(iconAsset, width: 18, height: 18, fit: BoxFit.contain),
          const SizedBox(width: 4),
        ],
        Text(label, style: style),
      ],
    );
  }
}
