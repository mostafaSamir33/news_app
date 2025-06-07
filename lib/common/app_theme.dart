import 'package:flutter/material.dart';
import 'package:news_app/common/app_colors.dart';
import 'package:news_app/common/custom_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.mainColorLight, brightness: Brightness.light),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.mainColorLight,
    textTheme: const TextTheme(
        bodySmall: CustomTextStyles.style14w500Black,
        bodyMedium: CustomTextStyles.style16w500Black,
        bodyLarge: CustomTextStyles.style18w500Black,
        labelSmall: CustomTextStyles.style20w500Black,
        labelMedium: CustomTextStyles.style24w500Black,
        labelLarge: CustomTextStyles.style14w700Black,
        titleSmall: CustomTextStyles.style16w700Black,
        titleMedium: CustomTextStyles.style18w700Black,
        titleLarge: CustomTextStyles.style20w700Black,
        displaySmall: CustomTextStyles.style24w700Black),
    dividerTheme: const DividerThemeData(
      color: AppColors.mainColorLight,
      thickness: 2,
      indent: 20,
      endIndent: 20,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.mainColorLight,
        foregroundColor: AppColors.mainColorDark,
        iconTheme: IconThemeData(color: AppColors.mainColorDark),
        centerTitle: true,
        titleTextStyle: CustomTextStyles.style20w500Black),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.mainColorDark, brightness: Brightness.dark),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.mainColorDark,
    textTheme: const TextTheme(
        bodySmall: CustomTextStyles.style14w500White,
        bodyMedium: CustomTextStyles.style16w500White,
        bodyLarge: CustomTextStyles.style18w500White,
        labelSmall: CustomTextStyles.style20w500White,
        labelMedium: CustomTextStyles.style24w500White,
        labelLarge: CustomTextStyles.style14w700White,
        titleSmall: CustomTextStyles.style16w700White,
        titleMedium: CustomTextStyles.style18w700White,
        titleLarge: CustomTextStyles.style20w700White,
        displaySmall: CustomTextStyles.style24w700White),
    dividerTheme: const DividerThemeData(
      color: AppColors.mainColorLight,
      thickness: 2,
      indent: 20,
      endIndent: 20,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.mainColorDark,
        foregroundColor: AppColors.mainColorLight,
        iconTheme: IconThemeData(color: AppColors.mainColorLight),
        centerTitle: true,
        titleTextStyle: CustomTextStyles.style20w500White),
  );
}
