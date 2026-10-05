import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../app_text_styles.dart';

class AppDialogActions extends StatelessWidget {
  final String? cancelLabel;
  final String? confirmLabel;
  final void Function()? onCancel;
  final void Function()? onConfirm;
  final bool confirmEnabled;

  const AppDialogActions({
    super.key,
    required this.cancelLabel,
    required this.confirmLabel,
    required this.onCancel,
    required this.onConfirm,
    required this.confirmEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final String? currentCancelLabel = cancelLabel;
    final String? currentConfirmLabel = confirmLabel;

    if (currentCancelLabel != null && currentConfirmLabel != null) {
      return Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: onCancel,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.mutedSurface,
                foregroundColor: AppColors.ink,
                minimumSize: const Size(0, 56),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: AppTextStyles.body.copyWith(
                  color: AppColors.ink,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Text(currentCancelLabel, textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: confirmEnabled ? onConfirm : null,
              style: FilledButton.styleFrom(
                backgroundColor: confirmEnabled
                    ? AppColors.coralDeep
                    : AppColors.disabledControl,
                foregroundColor: confirmEnabled
                    ? AppColors.surface
                    : AppColors.disabledText,
                minimumSize: const Size(0, 56),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: AppTextStyles.body.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Text(currentConfirmLabel, textAlign: TextAlign.center),
            ),
          ),
        ],
      );
    }

    if (currentCancelLabel != null) {
      return TextButton(
        onPressed: onCancel,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.mutedSurface,
          foregroundColor: AppColors.ink,
          minimumSize: const Size(0, 56),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.body.copyWith(
            color: AppColors.ink,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(currentCancelLabel, textAlign: TextAlign.center),
      );
    }

    if (currentConfirmLabel != null) {
      return FilledButton(
        onPressed: confirmEnabled ? onConfirm : null,
        style: FilledButton.styleFrom(
          backgroundColor: confirmEnabled
              ? AppColors.coralDeep
              : AppColors.disabledControl,
          foregroundColor: confirmEnabled
              ? AppColors.surface
              : AppColors.disabledText,
          minimumSize: const Size(0, 56),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.body.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(currentConfirmLabel, textAlign: TextAlign.center),
      );
    }

    return const SizedBox.shrink();
  }
}
