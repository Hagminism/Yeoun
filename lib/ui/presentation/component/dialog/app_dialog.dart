import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../app_text_styles.dart';
import 'app_dialog_actions.dart';

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
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
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
                            fontSize: 15,
                            color: AppColors.secondaryText,
                          ),
                        ),
                  ),
                ),
                if (cancelLabel != null || confirmLabel != null) ...[
                  const SizedBox(height: 24),
                  AppDialogActions(
                    cancelLabel: cancelLabel,
                    confirmLabel: confirmLabel,
                    onCancel: onCancel,
                    onConfirm: onConfirm,
                    confirmEnabled: confirmEnabled,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
