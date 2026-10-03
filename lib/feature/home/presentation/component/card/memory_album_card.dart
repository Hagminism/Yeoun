import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';

import '../../../../../core/domain/model/memory/memory_entry.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../header/home_card_header.dart';
import 'memory_photo_card.dart';

class MemoryAlbumCard extends StatelessWidget {
  final List<MemoryEntry> memories;
  final void Function() onOpen;

  const MemoryAlbumCard({
    super.key,
    required this.memories,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardSurface(
      minHeight: 259,
      child: Column(
        children: [
          HomeCardHeader(
            title: '공유 앨범 & 기억 조각',
            trailing: InkWell(
              onTap: onOpen,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '더보기',
                      style: AppTextStyles.small.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.coralDeep,
                      ),
                    ),
                    const AppAssetIcon(AppAssets.arrowMore),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var index = 0; index < memories.take(2).length; index++) ...[
                if (index > 0) const SizedBox(width: 12),
                Expanded(
                  child: MemoryPhotoCard(
                    memory: memories[index],
                    onOpen: onOpen,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
