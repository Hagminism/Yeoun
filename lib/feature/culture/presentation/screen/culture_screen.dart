import 'package:flutter/material.dart';

import '../../../../core/presentation/responsive/app_breakpoints.dart';
import '../../../../ui/app_colors.dart';
import '../../domain/model/culture_member.dart';
import '../../domain/model/culture_work.dart';
import '../component/culture_editor_panel.dart';
import '../component/section/culture_empty_work_board.dart';
import '../component/section/culture_intro_section.dart';
import '../component/section/culture_review_footnote.dart';
import '../component/section/culture_work_section_heading.dart';
import '../component/culture_member_switcher.dart';
import '../component/culture_page_header.dart';
import '../component/culture_work_card.dart';
import 'culture_action.dart';
import 'culture_state.dart';

class CultureScreen extends StatelessWidget {
  final CultureState state;
  final void Function(CultureAction action) onAction;

  const CultureScreen({super.key, required this.state, required this.onAction});

  @override
  Widget build(BuildContext context) {
    final CultureMember? activeMember = _activeMember;
    final CultureWork? editingWork = _editingWork;

    return Column(
      children: [
        CulturePageHeader(onAction: onAction, isEditing: state.editorVisible),
        Expanded(
          child: ColoredBox(
            color: AppColors.paper,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double horizontalPadding = constraints.maxWidth >= 760
                    ? 36
                    : 17;
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    18,
                    horizontalPadding,
                    35,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppBreakpoints.maxContentWidth,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CultureIntroSection(
                            memberName: activeMember?.name ?? '',
                          ),
                          const SizedBox(height: 16),
                          CultureMemberSwitcher(
                            members: state.members,
                            selectedMemberId: state.activeMemberId,
                            onSelected: (String memberId) {
                              onAction(CultureAction.memberSelected(memberId));
                            },
                          ),
                          if (state.editorVisible && activeMember != null) ...[
                            const SizedBox(height: 18),
                            CultureEditorPanel(
                              key: ValueKey<String>(
                                '${editingWork?.id ?? 'new'}:${activeMember.id}',
                              ),
                              work: editingWork,
                              existingReview: editingWork?.reviewFor(
                                activeMember.id,
                              ),
                              pendingArtworkBase64: state.pendingArtworkBase64,
                              message: state.editorMessage,
                              isPickingArtwork: state.isPickingArtwork,
                              memberName: activeMember.name,
                              onAction: onAction,
                            ),
                          ],
                          const SizedBox(height: 26),
                          CultureWorkSectionHeading(
                            workCount: state.works.length,
                            reviewCount: state.works.fold<int>(
                              0,
                              (int sum, CultureWork work) =>
                                  sum + work.reviews.length,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (state.works.isEmpty)
                            const CultureEmptyWorkBoard()
                          else
                            for (
                              int index = 0;
                              index < state.works.length;
                              index++
                            ) ...[
                              if (index > 0) const SizedBox(height: 13),
                              CultureWorkCard(
                                work: state.works[index],
                                members: state.members,
                                activeMemberId: state.activeMemberId,
                                onAction: onAction,
                              ),
                            ],
                          const SizedBox(height: 16),
                          const CultureReviewFootnote(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  CultureMember? get _activeMember {
    for (final CultureMember member in state.members) {
      if (member.id == state.activeMemberId) return member;
    }
    return null;
  }

  CultureWork? get _editingWork {
    final String? editingWorkId = state.editingWorkId;
    if (editingWorkId == null) return null;
    for (final CultureWork work in state.works) {
      if (work.id == editingWorkId) return work;
    }
    return null;
  }
}
