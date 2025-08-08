import 'package:flutter/material.dart';
import 'package:wahaj_app/theme/app_colors.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackground,
  primaryColor: AppColors.lightPrimary,
  cardColor: AppColors.lightItem,
  dividerColor: Colors.grey.shade300,
  fontFamily: 'Alexandria',
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightPrimary,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.lightText),
    bodyMedium: TextStyle(color: AppColors.lightText),
    bodySmall: TextStyle(color: AppColors.lightText),
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.lightPrimary,
    secondary: AppColors.lightItem,
    error: Colors.redAccent,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
  primaryColor: AppColors.darkPrimary,
  cardColor: AppColors.darkItem,
  dividerColor: AppColors.darkBorder,
  fontFamily: 'Alexandria',
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkPrimary,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkText),
    bodyMedium: TextStyle(color: AppColors.darkText),
    bodySmall: TextStyle(color: AppColors.darkText),
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkItem,
    error: Colors.redAccent,
  ),
);
