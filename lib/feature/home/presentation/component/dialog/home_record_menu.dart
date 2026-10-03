import 'package:flutter/material.dart';
import '../../../../../ui/app_text_styles.dart';

class HomeRecordMenu extends StatelessWidget {
  final void Function() onMemo;
  final void Function() onBucket;
  final void Function() onClose;

  const HomeRecordMenu({
    super.key,
    required this.onMemo,
    required this.onBucket,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('새 기록 작성', style: AppTextStyles.cardTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('오늘의 일기'),
            onTap: onMemo,
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('새 버킷'),
            onTap: onBucket,
          ),
        ],
      ),
      actions: [TextButton(onPressed: onClose, child: const Text('닫기'))],
    );
  }
}
