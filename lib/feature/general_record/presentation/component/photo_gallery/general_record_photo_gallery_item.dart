import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../domain/model/general_record_photo.dart';

class GeneralRecordPhotoGalleryItem extends StatelessWidget {
  final GeneralRecordPhoto photo;
  final void Function(String photoId) onRemove;

  const GeneralRecordPhotoGalleryItem({
    super.key,
    required this.photo,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(
              Uint8List.fromList(photo.bytes),
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder:
                  (
                    BuildContext context,
                    Object error,
                    StackTrace? stackTrace,
                  ) => const ColoredBox(color: AppColors.creamDeep),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: Semantics(
              button: true,
              label: '사진 삭제',
              child: Material(
                color: AppColors.ink.withValues(alpha: .76),
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => onRemove(photo.id),
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.close_rounded,
                      size: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
