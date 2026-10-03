import 'package:flutter/material.dart';
import '../../../../../ui/app_text_styles.dart';

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
    return AlertDialog(
      title: Text(title, style: AppTextStyles.cardTitle),
      content: SizedBox(
        width: 360,
        child: TextField(
          controller: controller,
          autofocus: true,
          minLines: multiline ? 4 : 1,
          maxLines: multiline ? 8 : 1,
          maxLength: multiline ? 500 : 80,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
          onSubmitted: (String value) {
            if (!multiline && value.trim().isNotEmpty) onSave(value);
          },
        ),
      ),
      actions: [
        TextButton(onPressed: onCancel, child: const Text('취소')),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder:
              (BuildContext context, TextEditingValue value, Widget? child) {
                return FilledButton(
                  onPressed: value.text.trim().isEmpty
                      ? null
                      : () {
                          onSave(value.text);
                        },
                  child: const Text('저장'),
                );
              },
        ),
      ],
    );
  }
}
