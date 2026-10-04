import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../../../domain/model/bucket_list_category.dart';
import '../../../domain/model/bucket_list_entry.dart';
import '../button/bucket_list_suggestion_button.dart';
import '../card/bucket_list_entry_card.dart';
import '../card/bucket_list_summary_card.dart';
import '../filter/bucket_list_filter_chips.dart';
import '../input/bucket_list_input_card.dart';
import '../section/bucket_list_completed_section.dart';
import '../../screen/bucket_list_action.dart';
import '../../screen/bucket_list_state.dart';

class BucketListContent extends StatelessWidget {
  final BucketListState state;
  final List<BucketListEntry> entries;
  final GlobalKey<FormState> inputFormKey;
  final FocusNode inputFocusNode;
  final void Function(BucketListAction) onAction;

  const BucketListContent({
    super.key,
    required this.state,
    required this.entries,
    required this.inputFormKey,
    required this.inputFocusNode,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final activeEntries = entries
        .where((BucketListEntry entry) => !entry.completed)
        .where(
          (BucketListEntry entry) =>
              state.selectedCategory == BucketListCategory.all ||
              entry.category == state.selectedCategory,
        )
        .toList(growable: false);
    final completedEntries = entries
        .where((BucketListEntry entry) => entry.completed)
        .toList(growable: false);
    final activeCount = entries
        .where((BucketListEntry entry) => !entry.completed)
        .length;

    return ColoredBox(
      color: AppColors.paper,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 30),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BucketListSummaryCard(
                  activeCount: activeCount,
                  completedCount: completedEntries.length,
                ),
                const SizedBox(height: 16),
                BucketListInputCard(
                  formKey: inputFormKey,
                  focusNode: inputFocusNode,
                  onChanged: (String value) {
                    onAction(BucketListAction.inputChanged(value));
                  },
                  onAdd: () {
                    onAction(const BucketListAction.addRequested());
                  },
                ),
                const SizedBox(height: 20),
                Text('진행 중 목록', style: AppTextStyles.cardTitle),
                const SizedBox(height: 9),
                BucketListFilterChips(
                  selectedCategory: state.selectedCategory,
                  onSelected: (BucketListCategory category) {
                    onAction(BucketListAction.filterSelected(category));
                  },
                ),
                const SizedBox(height: 14),
                if (activeEntries.isEmpty)
                  AppCardSurface(
                    child: Text(
                      '이 카테고리에는 진행 중인 버킷이 없어요.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  )
                else
                  for (
                    var index = 0;
                    index < activeEntries.length;
                    index++
                  ) ...[
                    BucketListEntryCard(
                      entry: activeEntries[index],
                      onToggle: () {
                        onAction(
                          BucketListAction.completionToggled(
                            activeEntries[index].id,
                          ),
                        );
                      },
                    ),
                    if (index != activeEntries.length - 1)
                      const SizedBox(height: 14),
                  ],
                const SizedBox(height: 22),
                BucketListCompletedSection(
                  entries: completedEntries,
                  expanded: state.completedExpanded,
                  onExpandedChanged: (bool expanded) {
                    onAction(
                      BucketListAction.completedExpandedChanged(expanded),
                    );
                  },
                  onToggle: (String id) {
                    onAction(BucketListAction.completionToggled(id));
                  },
                ),
                const SizedBox(height: 24),
                BucketListSuggestionButton(
                  onPressed: () {
                    onAction(const BucketListAction.focusInputRequested());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
