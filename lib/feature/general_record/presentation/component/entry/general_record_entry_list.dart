import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../domain/model/general_record.dart';
import '../../../domain/model/general_record_photo.dart';
import '../../../domain/model/general_record_view_mode.dart';
import '../../screen/general_record_action.dart';
import '../photo_viewer/general_record_photo_viewer.dart';
import '../view_toggle/general_record_view_toggle.dart';
import 'general_record_empty_state.dart';
import '../entry_card/general_record_entry_card.dart';

class GeneralRecordEntryList extends StatelessWidget {
  final List<GeneralRecord> entries;
  final GeneralRecordViewMode viewMode;
  final void Function(GeneralRecordAction) onAction;

  const GeneralRecordEntryList({
    super.key,
    required this.entries,
    required this.viewMode,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return GeneralRecordEmptyState(
        onAdd: () => onAction(const GeneralRecordAction.createRequested()),
      );
    }

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
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '전체 ${entries.length}개',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.bodyText,
                  fontSize: 12,
                ),
              ),
            ),
            const Spacer(),
            GeneralRecordViewToggle(
              selectedMode: viewMode,
              onSelected: (GeneralRecordViewMode mode) {
                onAction(GeneralRecordAction.viewModeSelected(mode));
              },
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (viewMode == GeneralRecordViewMode.feed)
          for (var index = 0; index < entries.length; index++) ...[
            GeneralRecordEntryCard(
              entry: entries[index],
              viewMode: GeneralRecordViewMode.feed,
              onEdit: () {
                onAction(GeneralRecordAction.editRequested(entries[index].id));
              },
              onPhotoTap: (List<GeneralRecordPhoto> photos, int initialIndex) {
                GeneralRecordPhotoViewer.show(context, photos, initialIndex);
              },
            ),
            if (index != entries.length - 1) const SizedBox(height: 14),
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
                itemCount: entries.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columnCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: 12,
                  mainAxisExtent: tileWidth + 84,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final GeneralRecord entry = entries[index];
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
}
