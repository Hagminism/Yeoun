import 'package:flutter/material.dart';
import 'package:yeoun/ui/app_assets.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../domain/model/general_record_photo.dart';
import '../../domain/model/general_record_view_mode.dart';
import '../component/general_record_editor.dart';
import '../component/general_record_entry_card.dart';
import '../component/general_record_photo_viewer.dart';
import '../component/general_record_view_toggle.dart';
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
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(18, 12, 18, bottomPadding),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: state.editorOpen
                      ? GeneralRecordEditor(state: state, onAction: onAction)
                      : _buildEntryList(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 64,
      padding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
      decoration: const BoxDecoration(color: AppColors.paper),
      child: Row(
        children: [
          _iconButton(
            icon: Icons.arrow_back_rounded,
            label: state.editorOpen ? '작성 취소' : '홈으로',
            onTap: state.editorOpen
                ? () => onAction(const GeneralRecordAction.editorDismissed())
                : () => onAction(const GeneralRecordAction.tapBackButton()),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              state.editorOpen
                  ? state.editingId == null
                        ? '새 기록'
                        : '기록 수정'
                  : '일기장',
              style: AppTextStyles.header.copyWith(fontSize: 18),
            ),
          ),
          if (!state.editorOpen)
            Semantics(
              button: true,
              label: '기록 추가',
              child: Material(
                color: AppColors.coralDeep,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () {
                    onAction(const GeneralRecordAction.createRequested());
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.add, color: Colors.white, size: 17),
                        const SizedBox(width: 2),
                        Text(
                          '기록',
                          style: AppTextStyles.caption.copyWith(
                            height: 1.42,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEntryList(BuildContext context) {
    if (state.entries.isEmpty) return _buildEmptyState();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('차곡차곡 모인 순간', style: AppTextStyles.heading.copyWith(fontSize: 22)),
        const SizedBox(height: 4),
        Text(
          '기록을 눌러 내용을 다시 다듬을 수 있어요.',
          style: AppTextStyles.small.copyWith(
            color: AppColors.secondaryText,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '전체 ${state.entries.length}개',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.bodyText,
                fontSize: 12,
              ),
            ),
            const Spacer(),
            GeneralRecordViewToggle(
              selectedMode: state.viewMode,
              onSelected: (GeneralRecordViewMode mode) {
                onAction(GeneralRecordAction.viewModeSelected(mode));
              },
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (state.viewMode == GeneralRecordViewMode.feed)
          for (var index = 0; index < state.entries.length; index++) ...[
            GeneralRecordEntryCard(
              entry: state.entries[index],
              viewMode: GeneralRecordViewMode.feed,
              onEdit: () {
                onAction(
                  GeneralRecordAction.editRequested(state.entries[index].id),
                );
              },
              onPhotoTap: (List<GeneralRecordPhoto> photos, int initialIndex) {
                GeneralRecordPhotoViewer.show(context, photos, initialIndex);
              },
            ),
            if (index != state.entries.length - 1) const SizedBox(height: 14),
          ]
        else
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final columnCount = constraints.maxWidth >= 510 ? 3 : 2;
              const crossAxisSpacing = 11.0;
              final tileWidth =
                  (constraints.maxWidth -
                      crossAxisSpacing * (columnCount - 1)) /
                  columnCount;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.entries.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columnCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: 12,
                  mainAxisExtent: tileWidth + 84,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final entry = state.entries[index];
                  return GeneralRecordEntryCard(
                    entry: entry,
                    viewMode: GeneralRecordViewMode.album,
                    onEdit: () {
                      onAction(GeneralRecordAction.editRequested(entry.id));
                    },
                    onPhotoTap:
                        (List<GeneralRecordPhoto> photos, int initialIndex) {
                          GeneralRecordPhotoViewer.show(
                            context,
                            photos,
                            initialIndex,
                          );
                        },
                  );
                },
              );
            },
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          Image.asset(AppAssets.sparkle3d, width: 64, height: 64),
          const SizedBox(height: 18),
          Text(
            '아직 모인 기억이 없어요',
            style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 6),
          Text(
            '처음으로 남긴 순간이 이곳의 시작이 돼요.',
            textAlign: TextAlign.center,
            style: AppTextStyles.small.copyWith(
              color: AppColors.secondaryText,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 18),
          _primaryAction(
            label: '첫 기록 남기기',
            onTap: () {
              onAction(const GeneralRecordAction.createRequested());
            },
          ),
        ],
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required String label,
    required void Function() onTap,
  }) {
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: AppColors.bodyText, size: 21),
        ),
      ),
    );
  }

  Widget _primaryAction({
    required String label,
    required void Function() onTap,
  }) {
    return Material(
      color: AppColors.coralDeep,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
          child: Text(
            label,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
