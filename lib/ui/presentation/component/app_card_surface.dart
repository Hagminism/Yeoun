import 'package:flutter/material.dart';
import '../../app_colors.dart';

class AppCardSurface extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final double offset;
  final double minHeight;

  const AppCardSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 16,
    this.offset = 6,
    this.minHeight = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.ink),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(color: AppColors.canvas, offset: Offset(offset, offset)),
        ],
      ),
      child: child,
    );
  }
}
