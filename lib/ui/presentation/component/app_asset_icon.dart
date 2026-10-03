import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssetIcon extends StatelessWidget {
  final String asset;

  const AppAssetIcon(this.asset, {super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(asset);
  }
}
