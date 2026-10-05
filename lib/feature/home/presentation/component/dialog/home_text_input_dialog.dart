import 'package:flutter/material.dart';
import '../../../../../ui/presentation/component/dialog/app_dialog.dart';

class HomeTextInputDialog extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final bool multiline;
  final void Function() onCancel;
  final void Function(String) onSave;

  const HomeTextInputDialog({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.onCancel,
    required this.onSave,
    this.multiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (BuildContext context, TextEditingValue value, Widget? child) {
        return AppDialog(
          title: title,
          content: TextField(
            controller: controller,
            autofocus: true,
            minLines: multiline ? 4 : 1,
            maxLines: multiline ? 8 : 1,
            maxLength: multiline ? 500 : 80,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (String input) {
              if (!multiline && input.trim().isNotEmpty) onSave(input);
            },
          ),
          cancelLabel: '취소',
          onCancel: onCancel,
          confirmLabel: '저장',
          onConfirm: () {
            onSave(value.text);
          },
          confirmEnabled: value.text.trim().isNotEmpty,
        );
      },
    );
  }
}
