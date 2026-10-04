import 'package:flutter/material.dart';

import '../../../../core/presentation/responsive/app_breakpoints.dart';
import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../domain/model/culture_member.dart';
import '../../domain/model/culture_work.dart';
import '../component/culture_editor_panel.dart';
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
                          _intro(activeMember?.name ?? ''),
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
                          _sectionHeading(),
                          const SizedBox(height: 12),
                          if (state.works.isEmpty)
                            _emptyBoard()
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
                          _footnote(),
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

  Widget _intro(String memberName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CULTURE ARCHIVE   /   01',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.cultureText,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '좋아한 장면들이 모여\n우리의 취향이 됩니다.',
          style: AppTextStyles.title.copyWith(
            fontSize: 25,
            height: 1.34,
            letterSpacing: -.5,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          memberName.isEmpty
              ? '작품마다 각자의 평점을 남겨보세요.'
              : '$memberName님으로 기록 중 · 작품마다 감상은 한 번씩 남길 수 있어요.',
          style: AppTextStyles.small.copyWith(
            color: AppColors.secondaryText,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _sectionHeading() {
    final int reviewCount = state.works.fold<int>(
      0,
      (int sum, CultureWork work) => sum + work.reviews.length,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OUR SHELF',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.secondaryText,
                  letterSpacing: .9,
                  fontSize: 9,
                ),
              ),
              const SizedBox(height: 2),
              Text('함께 남긴 작품', style: AppTextStyles.heading),
            ],
          ),
        ),
        Text(
          '작품 ${state.works.length} · 감상 $reviewCount',
          style: AppTextStyles.caption.copyWith(color: AppColors.secondaryText),
        ),
      ],
    );
  }

  Widget _emptyBoard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
      decoration: BoxDecoration(
        color: AppColors.cream,
        border: Border.all(color: AppColors.borderSoft),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.local_movies_outlined,
            color: AppColors.cultureText,
            size: 31,
          ),
          const SizedBox(height: 9),
          Text('첫 작품을 기록해 볼까요?', style: AppTextStyles.cardTitle),
          const SizedBox(height: 4),
          Text(
            '영화부터 음악까지, 오래 간직하고 싶은 감상을 모아보세요.',
            textAlign: TextAlign.center,
            style: AppTextStyles.small.copyWith(color: AppColors.secondaryText),
          ),
        ],
      ),
    );
  }

  Widget _footnote() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.info_outline_rounded,
          size: 14,
          color: AppColors.disabledText,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            '공간 평균은 감상을 등록한 사람들의 평점으로 계산해요.',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
        ),
      ],
    );
  }
}
