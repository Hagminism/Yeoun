import 'package:flutter/material.dart';

import '../../../../domain/model/general_record_photo.dart';
import '../shared/general_record_photo_button.dart';

class GeneralRecordPhotoStrip extends StatelessWidget {
  final List<GeneralRecordPhoto> photos;
  final void Function(List<GeneralRecordPhoto>, int) onPhotoTap;

  const GeneralRecordPhotoStrip({
    super.key,
    required this.photos,
    required this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final GeneralRecordPhoto photo = photos[index];
          return SizedBox(
            height: 112,
            width: 112,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GeneralRecordPhotoButton(
                photo: photo,
                photos: photos,
                index: index,
                fit: BoxFit.cover,
                onPhotoTap: onPhotoTap,
              ),
            ),
          );
        },
      ),
    );
  }
}
