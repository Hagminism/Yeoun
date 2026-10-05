import 'package:flutter/material.dart';

import '../../domain/model/general_record.dart';
import '../../domain/model/general_record_photo.dart';
import '../../domain/model/general_record_view_mode.dart';
import 'entry_card/album/general_record_album_card_content.dart';
import 'entry_card/feed/general_record_feed_card_content.dart';

class GeneralRecordEntryCard extends StatelessWidget {
  final GeneralRecord entry;
  final GeneralRecordViewMode viewMode;
  final void Function() onEdit;
  final void Function(List<GeneralRecordPhoto>, int) onPhotoTap;

  const GeneralRecordEntryCard({
    super.key,
    required this.entry,
    required this.viewMode,
    required this.onEdit,
    required this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    if (viewMode == GeneralRecordViewMode.album) {
      return GeneralRecordAlbumCardContent(
        entry: entry,
        onEdit: onEdit,
        onPhotoTap: onPhotoTap,
      );
    }
    return GeneralRecordFeedCardContent(
      entry: entry,
      onEdit: onEdit,
      onPhotoTap: onPhotoTap,
    );
  }
}
