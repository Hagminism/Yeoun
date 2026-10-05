import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../component/entry/general_record_entry_list.dart';
import '../component/general_record_editor.dart';
import '../component/header/general_record_header.dart';
import 'general_record_action.dart';
import 'general_record_state.dart';

class GeneralRecordScreen extends StatelessWidget {
  final GeneralRecordState state;
  final void Function(GeneralRecordAction) onAction;

  const GeneralRecordScreen({
    super.key,
    required this.state,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 24;

    return ColoredBox(
      color: AppColors.paper,
      child: Column(
        children: [
          GeneralRecordHeader(state: state, onAction: onAction),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(18, 12, 18, bottomPadding),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: state.editorOpen
                      ? GeneralRecordEditor(state: state, onAction: onAction)
                      : GeneralRecordEntryList(
                          entries: state.entries,
                          viewMode: state.viewMode,
                          onAction: onAction,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
