import 'package:flutter/material.dart';

import '../../../../../../ui/app_assets.dart';
import '../../../../../../ui/presentation/component/app_asset_icon.dart';

class GeneralRecordEditButton extends StatelessWidget {
  final void Function() onEdit;

  const GeneralRecordEditButton({super.key, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '기록 수정',
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onEdit,
          customBorder: const CircleBorder(),
          child: const SizedBox(
            width: 32,
            height: 32,
            child: Center(
              child: AppAssetIcon(AppAssets.pencil3d, width: 18, height: 18),
            ),
          ),
        ),
      ),
    );
  }
}
