import 'package:flutter/material.dart';

import '../../../../../../ui/app_text_styles.dart';
import '../../../../domain/model/general_record.dart';
import '../../../../domain/model/general_record_photo.dart';
import '../../../../../../ui/presentation/component/app_card_surface.dart';
import '../shared/general_record_date_label.dart';
import '../shared/general_record_edit_button.dart';
import 'general_record_photo_strip.dart';

class GeneralRecordFeedCardContent extends StatelessWidget {
  final GeneralRecord entry;
  final void Function() onEdit;
  final void Function(List<GeneralRecordPhoto>, int) onPhotoTap;

  const GeneralRecordFeedCardContent({
    super.key,
    required this.entry,
    required this.onEdit,
    required this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardSurface(
      padding: EdgeInsets.zero,
      radius: 16,
      offset: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: GeneralRecordDateLabel(date: entry.recordedAt)),
                GeneralRecordEditButton(onEdit: onEdit),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              entry.content,
              style: AppTextStyles.cardBody.copyWith(fontSize: 14),
            ),
            if (entry.photos.isNotEmpty) ...[
              const SizedBox(height: 14),
              GeneralRecordPhotoStrip(
                photos: entry.photos,
                onPhotoTap: onPhotoTap,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
