import 'package:flutter/material.dart';
import '../../../../../ui/presentation/component/dialog/app_dialog.dart';

class HomeRecordMenu extends StatelessWidget {
  final void Function() onGeneralRecord;
  final void Function() onBucket;
  final void Function() onClose;

  const HomeRecordMenu({
    super.key,
    required this.onGeneralRecord,
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
            title: const Text('일반 기록'),
            onTap: onGeneralRecord,
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
