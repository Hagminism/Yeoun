import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../domain/model/general_record_photo.dart';

class GeneralRecordPhotoGallery extends StatelessWidget {
  final List<GeneralRecordPhoto> photos;
  final bool selectingPhotos;
  final bool allowAdd;
  final void Function() onAdd;
  final void Function(String) onRemove;

  const GeneralRecordPhotoGallery({
    super.key,
    required this.photos,
    required this.selectingPhotos,
    required this.allowAdd,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('사진', style: AppTextStyles.cardTitle),
            const SizedBox(width: 7),
            Text(
              '${photos.length}/5',
              style: AppTextStyles.caption.copyWith(color: AppColors.coralDeep),
            ),
          ],
        ),
        const SizedBox(height: 9),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length + (allowAdd ? 1 : 0),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 9),
            itemBuilder: (BuildContext context, int index) {
              if (index == photos.length) return _buildAddTile();
              return _buildPhotoTile(photos[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddTile() {
    return Semantics(
      button: true,
      label: '사진 추가',
      child: Material(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: selectingPhotos ? null : onAdd,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 90,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderSoft),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  selectingPhotos
                      ? Icons.more_horiz
                      : Icons.add_photo_alternate_outlined,
                  color: AppColors.coralDeep,
                ),
                const SizedBox(height: 4),
                Text(
                  selectingPhotos ? '불러오는 중' : '사진 추가',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.bodyText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoTile(GeneralRecordPhoto photo) {
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
