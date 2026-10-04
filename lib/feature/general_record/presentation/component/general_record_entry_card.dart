import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../../../ui/presentation/component/app_card_surface.dart';
import '../../domain/model/general_record.dart';
import '../../domain/model/general_record_photo.dart';
import '../../domain/model/general_record_view_mode.dart';

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
    if (viewMode == GeneralRecordViewMode.album) return _buildAlbumCard();
    return _buildFeedCard();
  }

  Widget _buildFeedCard() {
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
                Expanded(child: _buildDateLabel(entry.recordedAt)),
                _buildEditButton(),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              entry.content,
              style: AppTextStyles.cardBody.copyWith(fontSize: 14),
            ),
            if (entry.photos.isNotEmpty) ...[
              const SizedBox(height: 14),
              _buildPhotoRow(entry.photos),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumCard() {
    final photo = entry.photos.isEmpty ? null : entry.photos.first;
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
                borderRadius: BorderRadius.only(
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
                      : _buildPhotoButton(
                          photo,
                          photos: entry.photos,
                          index: 0,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(top: 8, right: 8, child: _buildEditButton()),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 9, 10, 11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateLabel(entry.recordedAt),
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

  Widget _buildDateLabel(DateTime date) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              size: 13,
              color: AppColors.coral,
            ),
            const SizedBox(width: 6),
            Text(
              '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}',
              style: AppTextStyles.caption,
            ),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  Widget _buildPhotoRow(List<GeneralRecordPhoto> photos) {
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
              child: _buildPhotoButton(
                photo,
                photos: photos,
                index: index,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPhotoButton(
    GeneralRecordPhoto photo, {
    required List<GeneralRecordPhoto> photos,
    required int index,
    required BoxFit fit,
  }) {
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

  Widget _buildEditButton() {
    return Semantics(
      button: true,
      label: '기록 수정',
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onEdit,
          customBorder: const CircleBorder(),
          child: const SizedBox(
            width: 32,
            height: 32,
            child: Icon(
              Icons.edit_outlined,
              size: 16,
              color: AppColors.coralDeep,
            ),
          ),
        ),
      ),
    );
  }
}
