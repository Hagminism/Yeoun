import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../../../ui/app_colors.dart';
import '../../../../../../ui/app_text_styles.dart';
import '../../../../domain/model/general_record.dart';

class GeneralRecordRecordPreview extends StatelessWidget {
  final GeneralRecord record;
  final String formattedDate;

  const GeneralRecordRecordPreview({
    super.key,
    required this.record,
    required this.formattedDate,
  });

  @override
  Widget build(BuildContext context) {
    final photo = record.photos.isEmpty ? null : record.photos.first;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: photo == null
              ? null
              : Image.memory(
                  Uint8List.fromList(photo.bytes),
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (
                        BuildContext context,
                        Object error,
                        StackTrace? stackTrace,
                      ) => const SizedBox(
                        width: 48,
                        height: 48,
                        child: ColoredBox(
                          color: AppColors.creamDeep,
                          child: Icon(
                            Icons.image_outlined,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                ),
        ),
        if (photo != null) const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                record.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.small.copyWith(
                  color: AppColors.ink,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 3),
              Text(formattedDate, style: AppTextStyles.caption),
            ],
          ),
        ),
      ],
    );
  }
}
