import 'package:flutter/material.dart';

import 'ui/app_colors.dart';
import 'ui/app_text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yeoun',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: AppColors.coral,
          onPrimary: AppColors.ink,
          secondary: AppColors.sage,
          onSecondary: AppColors.sageText,
          surface: AppColors.surface,
          onSurface: AppColors.ink,
        ),
        scaffoldBackgroundColor: AppColors.paper,
        textTheme: AppTextStyles.textTheme,
        fontFamily: AppTextStyles.fontFamily,
        fontFamilyFallback: AppTextStyles.fontFamilyFallback,
      ),
      home: const Scaffold(),
    );
  }
}
