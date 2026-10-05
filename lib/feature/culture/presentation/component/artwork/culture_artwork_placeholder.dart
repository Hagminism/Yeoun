import 'package:flutter/material.dart';

import '../../../../../ui/app_assets.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';
import '../../../domain/model/culture_kind.dart';

class CultureArtworkPlaceholder extends StatelessWidget {
  final CultureKind kind;

  const CultureArtworkPlaceholder({super.key, required this.kind});

  @override
  Widget build(BuildContext context) {
    final Widget icon = switch (kind) {
      CultureKind.movie || CultureKind.drama => const AppAssetIcon(
        AppAssets.movieProjector3d,
        width: 32,
        height: 32,
      ),
      CultureKind.book => const Icon(
        Icons.menu_book_rounded,
        color: AppColors.cultureText,
        size: 28,
      ),
      CultureKind.game => const Icon(
        Icons.sports_esports_rounded,
        color: AppColors.cultureText,
        size: 28,
      ),
      CultureKind.music => const Icon(
        Icons.music_note_rounded,
        color: AppColors.cultureText,
        size: 28,
      ),
      CultureKind.performance => const Icon(
        Icons.theater_comedy_rounded,
        color: AppColors.cultureText,
        size: 28,
      ),
      CultureKind.other => const Icon(
        Icons.auto_awesome_rounded,
        color: AppColors.cultureText,
        size: 28,
      ),
    };

    return ColoredBox(
      color: AppColors.cream,
      child: Center(child: icon),
    );
  }
}
