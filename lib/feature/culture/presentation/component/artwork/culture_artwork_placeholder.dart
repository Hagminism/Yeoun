import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../domain/model/culture_kind.dart';

class CultureArtworkPlaceholder extends StatelessWidget {
  final CultureKind kind;

  const CultureArtworkPlaceholder({super.key, required this.kind});

  @override
  Widget build(BuildContext context) {
    final IconData icon = switch (kind) {
      CultureKind.movie || CultureKind.drama => Icons.local_movies_outlined,
      CultureKind.book => Icons.menu_book_rounded,
      CultureKind.game => Icons.sports_esports_rounded,
      CultureKind.music => Icons.music_note_rounded,
      CultureKind.performance => Icons.theater_comedy_rounded,
      CultureKind.other => Icons.auto_awesome_rounded,
    };

    return ColoredBox(
      color: AppColors.cream,
      child: Center(child: Icon(icon, color: AppColors.cultureText, size: 28)),
    );
  }
}
