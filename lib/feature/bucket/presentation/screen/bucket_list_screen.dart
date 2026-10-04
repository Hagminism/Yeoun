import 'package:flutter/material.dart';

import 'bucket_list_action.dart';
import 'bucket_list_state.dart';
import '../component/header/bucket_list_header.dart';
import '../component/layout/bucket_list_content.dart';
import '../../domain/model/bucket_list_entry.dart';

class BucketListScreen extends StatelessWidget {
  final BucketListState state;
  final List<BucketListEntry> entries;
  final GlobalKey<FormState> inputFormKey;
  final FocusNode inputFocusNode;
  final void Function() onOpenSettings;
  final void Function(BucketListAction) onAction;

  const BucketListScreen({
    super.key,
    required this.state,
    required this.entries,
    required this.inputFormKey,
    required this.inputFocusNode,
    required this.onOpenSettings,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BucketListHeader(
          onAdd: () {
            onAction(const BucketListAction.focusInputRequested());
          },
          onNotifications: () {
            onAction(const BucketListAction.notificationsRequested());
          },
          onSettings: onOpenSettings,
        ),
        Expanded(
          child: BucketListContent(
            state: state,
            entries: entries,
            inputFormKey: inputFormKey,
            inputFocusNode: inputFocusNode,
            onAction: onAction,
          ),
        ),
      ],
    );
  }
}
