import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../domain/model/general_record_photo.dart';
import 'photo_viewer/general_record_photo_navigation_button.dart';

class GeneralRecordPhotoViewer extends StatefulWidget {
  final List<GeneralRecordPhoto> photos;
  final int initialIndex;

  const GeneralRecordPhotoViewer({
    super.key,
    required this.photos,
    required this.initialIndex,
  });

  static Future<void> show(
    BuildContext context,
    List<GeneralRecordPhoto> photos,
    int initialIndex,
  ) {
    if (photos.isEmpty) return Future<void>.value();

    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: '사진 보기 닫기',
      barrierColor: Colors.black.withValues(alpha: 0.4),
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (context, animation, secondaryAnimation) {
        return GeneralRecordPhotoViewer(
          photos: photos,
          initialIndex: initialIndex,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  @override
  State<GeneralRecordPhotoViewer> createState() =>
      _GeneralRecordPhotoViewerState();
}

class _GeneralRecordPhotoViewerState extends State<GeneralRecordPhotoViewer> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.photos.length - 1);
  }

  void _move(int offset) {
    final int nextIndex = _currentIndex + offset;
    if (nextIndex < 0 || nextIndex >= widget.photos.length) return;
    setState(() {
      _currentIndex = nextIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GeneralRecordPhoto photo = widget.photos[_currentIndex];
    final bool hasMultiplePhotos = widget.photos.length > 1;

    return ColoredBox(
      color: Colors.black.withValues(alpha: 0.4),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  hasMultiplePhotos ? 64 : 12,
                  64,
                  hasMultiplePhotos ? 64 : 12,
                  hasMultiplePhotos ? 68 : 20,
                ),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return InteractiveViewer(
                      key: ValueKey<String>(photo.id),
                      minScale: 1,
                      maxScale: 4,
                      child: SizedBox(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        child: Image.memory(
                          Uint8List.fromList(photo.bytes),
                          fit: BoxFit.contain,
                          errorBuilder:
                              (
                                BuildContext context,
                                Object error,
                                StackTrace? stackTrace,
                              ) => const Icon(
                                Icons.broken_image_outlined,
                                color: AppColors.paper,
                                size: 44,
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (hasMultiplePhotos) ...[
              Positioned(
                left: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GeneralRecordPhotoNavigationButton(
                    previous: true,
                    enabled: _currentIndex > 0,
                    onTap: () => _move(-1),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GeneralRecordPhotoNavigationButton(
                    previous: false,
                    enabled: _currentIndex < widget.photos.length - 1,
                    onTap: () => _move(1),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 18,
                child: Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.paper.withValues(alpha: .16),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        '${_currentIndex + 1} / ${widget.photos.length}',
                        style: AppTextStyles.small.copyWith(
                          color: AppColors.paper,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            Positioned(
              top: 12,
              right: 12,
              child: Semantics(
                button: true,
                label: '사진 닫기',
                child: Material(
                  color: AppColors.paper.withValues(alpha: .14),
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    customBorder: const CircleBorder(),
                    child: const SizedBox(
                      width: 42,
                      height: 42,
                      child: Icon(Icons.close_rounded, color: AppColors.paper),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
