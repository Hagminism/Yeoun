import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../domain/model/culture_kind.dart';
import 'artwork/culture_artwork_placeholder.dart';

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
                  return CultureArtworkPlaceholder(kind: kind);
                },
          )
        : artworkAsset.isNotEmpty
        ? Image.asset(
            artworkAsset,
            fit: BoxFit.cover,
            errorBuilder:
                (BuildContext context, Object error, StackTrace? trace) {
                  return CultureArtworkPlaceholder(kind: kind);
                },
          )
        : CultureArtworkPlaceholder(kind: kind);

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
}
