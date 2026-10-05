import 'package:flutter/material.dart';

import '../../../../../../ui/app_colors.dart';

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
            child: Icon(
              Icons.edit_outlined,
              size: 16,
              color: AppColors.coralDeep,
            ),
          ),
        ),
      ),
    );
  }
}
