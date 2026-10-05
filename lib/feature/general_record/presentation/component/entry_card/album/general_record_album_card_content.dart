import 'package:flutter/material.dart';

import '../../../../../../ui/app_colors.dart';
import '../../../../../../ui/app_text_styles.dart';
import '../../../../domain/model/general_record.dart';
import '../../../../domain/model/general_record_photo.dart';
import '../shared/general_record_date_label.dart';
import '../shared/general_record_edit_button.dart';
import '../shared/general_record_photo_button.dart';

class GeneralRecordAlbumCardContent extends StatelessWidget {
  final GeneralRecord entry;
  final void Function() onEdit;
  final void Function(List<GeneralRecordPhoto>, int) onPhotoTap;

  const GeneralRecordAlbumCardContent({
    super.key,
    required this.entry,
    required this.onEdit,
    required this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    final GeneralRecordPhoto? photo = entry.photos.isEmpty
        ? null
        : entry.photos.first;

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: photo == null
                      ? const ColoredBox(
                          color: AppColors.cream,
                          child: Center(
                            child: Icon(
                              Icons.auto_awesome,
                              color: AppColors.coral,
                              size: 28,
                            ),
                          ),
                        )
                      : GeneralRecordPhotoButton(
                          photo: photo,
                          photos: entry.photos,
                          index: 0,
                          fit: BoxFit.cover,
                          onPhotoTap: onPhotoTap,
                        ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GeneralRecordEditButton(onEdit: onEdit),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 9, 10, 11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GeneralRecordDateLabel(date: entry.recordedAt),
                const SizedBox(height: 5),
                Text(
                  entry.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.small.copyWith(color: AppColors.ink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
