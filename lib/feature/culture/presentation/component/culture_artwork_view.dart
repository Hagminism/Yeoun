import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../domain/model/culture_kind.dart';

class CultureArtworkView extends StatelessWidget {
  final String artworkBase64;
  final String artworkAsset;
  final CultureKind kind;
  final double width;
  final double height;

  const CultureArtworkView({
    super.key,
    required this.artworkBase64,
    required this.artworkAsset,
    required this.kind,
    this.width = 88,
    this.height = 118,
  });

  @override
  Widget build(BuildContext context) {
    final Widget image = artworkBase64.isNotEmpty
        ? Image.memory(
            base64Decode(artworkBase64),
            fit: BoxFit.cover,
            errorBuilder:
                (BuildContext context, Object error, StackTrace? trace) {
                  return _placeholder();
                },
          )
        : artworkAsset.isNotEmpty
        ? Image.asset(
            artworkAsset,
            fit: BoxFit.cover,
            errorBuilder:
                (BuildContext context, Object error, StackTrace? trace) {
                  return _placeholder();
                },
          )
        : _placeholder();

    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderSoft),
      ),
      child: image,
    );
  }

  Widget _placeholder() {
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
