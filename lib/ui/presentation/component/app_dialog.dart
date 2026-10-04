import 'package:flutter/material.dart';

import '../../app_colors.dart';
import '../../app_text_styles.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? content;
  final String? cancelLabel;
  final String? confirmLabel;
  final void Function()? onCancel;
  final void Function()? onConfirm;
  final bool confirmEnabled;

  const AppDialog({
    super.key,
    required this.title,
    this.message,
    this.content,
    this.cancelLabel,
    this.confirmLabel,
    this.onCancel,
    this.onConfirm,
    this.confirmEnabled = true,
  }) : assert((message == null) != (content == null)),
       assert((cancelLabel == null) == (onCancel == null)),
       assert((confirmLabel == null) == (onConfirm == null));

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: const Color(0x8A000000),
      builder: builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget? dialogContent = content;
    final String? dialogMessage = message;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 540,
          maxHeight: MediaQuery.sizeOf(context).height * .84,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.paper,
            border: Border.all(color: AppColors.borderSoft),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.ink.withValues(alpha: .16),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    title,
                    style: AppTextStyles.heading.copyWith(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  fit: FlexFit.loose,
                  child: SingleChildScrollView(
                    child:
                        dialogContent ??
                        Text(
                          dialogMessage ?? '',
                          style: AppTextStyles.body.copyWith(
                            fontSize: 16,
                            height: 1.5,
                            color: AppColors.secondaryText,
                          ),
                        ),
                  ),
                ),
                if (cancelLabel != null || confirmLabel != null) ...[
                  const SizedBox(height: 24),
                  _buildActions(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActions() {
    final String? dialogCancelLabel = cancelLabel;
    final String? dialogConfirmLabel = confirmLabel;

    if (dialogCancelLabel != null && dialogConfirmLabel != null) {
      return Row(
        children: [
          Expanded(child: _buildCancelButton(dialogCancelLabel)),
          const SizedBox(width: 12),
          Expanded(child: _buildConfirmButton(dialogConfirmLabel)),
        ],
      );
    }

    if (dialogCancelLabel != null) {
      return _buildCancelButton(dialogCancelLabel);
    }

    if (dialogConfirmLabel != null) {
      return _buildConfirmButton(dialogConfirmLabel);
    }

    return const SizedBox.shrink();
  }

  Widget _buildCancelButton(String label) {
    return TextButton(
      onPressed: onCancel,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.mutedSurface,
        foregroundColor: AppColors.ink,
        minimumSize: const Size(0, 56),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: AppTextStyles.body.copyWith(
          color: AppColors.ink,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Text(label, textAlign: TextAlign.center),
    );
  }

  Widget _buildConfirmButton(String label) {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: AppTextStyles.body.copyWith(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Text(label, textAlign: TextAlign.center),
    );
  }
}
