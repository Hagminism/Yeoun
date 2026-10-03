import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static const String fontFamily = 'Pretendard';
  static const List<String> fontFamilyFallback = <String>['Inter'];

  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 36,
    fontWeight: FontWeight.w900,
    height: 1.21,
    color: AppColors.displayInk,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 26,
    fontWeight: FontWeight.w900,
    height: 1.21,
    color: AppColors.ink,
  );

  static const TextStyle heading = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    height: 1.21,
    color: AppColors.ink,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.21,
    color: AppColors.bodyText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.21,
    color: AppColors.secondaryText,
  );

  static const TextTheme textTheme = TextTheme(
    displaySmall: display,
    headlineSmall: title,
    titleMedium: heading,
    bodyMedium: body,
    labelSmall: caption,
  );

  static final TextStyle header = body.copyWith(
    fontSize: 17,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
    letterSpacing: -.425,
  );
  static final TextStyle cardTitle = body.copyWith(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );
  static final TextStyle cardBody = body.copyWith(
    fontSize: 13,
    height: 1.5,
    color: AppColors.ink,
  );
  static final TextStyle small = body.copyWith(
    fontSize: 12,
    height: 1.5,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle badge = caption.copyWith(
    height: 1.5,
    color: AppColors.bodyText,
  );
  static final TextStyle hero = title.copyWith(
    height: 1.5,
    fontWeight: FontWeight.w800,
    letterSpacing: -.65,
  );
}
