import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../core/domain/model/memory/memory_entry.dart';

class MemoryPhotoCard extends StatelessWidget {
  final MemoryEntry memory;
  final void Function() onOpen;

  const MemoryPhotoCard({
    super.key,
    required this.memory,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderSoft),
      ),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 138 / 128,
                  child: Image.asset(
                    memory.imageAsset,
                    fit: BoxFit.cover,
                    semanticLabel: memory.title,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                memory.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.small.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              Text(
                memory.subtitle,
                style: AppTextStyles.badge.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
