import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../../../ui/app_colors.dart';
import '../../../../domain/model/general_record_photo.dart';

class GeneralRecordPhotoButton extends StatelessWidget {
  final GeneralRecordPhoto photo;
  final List<GeneralRecordPhoto> photos;
  final int index;
  final BoxFit fit;
  final void Function(List<GeneralRecordPhoto>, int) onPhotoTap;

  const GeneralRecordPhotoButton({
    super.key,
    required this.photo,
    required this.photos,
    required this.index,
    required this.fit,
    required this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${photo.fileName} 사진 확대',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onPhotoTap(photos, index),
        child: Image.memory(
          Uint8List.fromList(photo.bytes),
          fit: fit,
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) =>
                  const ColoredBox(color: AppColors.cream),
        ),
      ),
    );
  }
}
