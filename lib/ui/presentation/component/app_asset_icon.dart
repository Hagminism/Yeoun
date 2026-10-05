import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssetIcon extends StatelessWidget {
  final String asset;
  final Color? tint;
  final double? width;
  final double? height;

  const AppAssetIcon(
    this.asset, {
    super.key,
    this.tint,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (asset.toLowerCase().endsWith('.png')) {
      return Image.asset(
        asset,
        width: width ?? 24,
        height: height ?? 24,
        fit: BoxFit.contain,
      );
    }

    return SvgPicture.asset(
      asset,
      width: width,
      height: height,
      colorFilter: tint == null
          ? null
          : ColorFilter.mode(tint!, BlendMode.srcIn),
    );
  }
}
