import 'package:flutter/material.dart';
import '../../../../../ui/presentation/component/app_dialog.dart';

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
    return AppDialog(
      title: '새 기록 작성',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.edit_outlined),
            title: const Text('오늘의 일기'),
            onTap: onMemo,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.checklist),
            title: const Text('새 버킷'),
            onTap: onBucket,
          ),
        ],
      ),
      cancelLabel: '닫기',
      onCancel: onClose,
    );
  }
}
