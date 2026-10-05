import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';

class GeneralRecordPhotoNavigationButton extends StatelessWidget {
  final bool previous;
  final bool enabled;
  final void Function() onTap;

  const GeneralRecordPhotoNavigationButton({
    super.key,
    required this.previous,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: enabled,
      label: previous ? '이전 사진' : '다음 사진',
      child: Material(
        color: AppColors.paper.withValues(alpha: enabled ? .92 : .24),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: enabled ? onTap : null,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 46,
            height: 46,
            child: Icon(
              previous
                  ? Icons.chevron_left_rounded
                  : Icons.chevron_right_rounded,
              color: enabled ? AppColors.ink : AppColors.secondaryText,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
