import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'consts.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.surfaceLight,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.surfaceLight,
    surfaceTintColor: Colors.transparent
  ),
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    displayLarge: GoogleFonts.roboto().copyWith(fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.roboto().copyWith(fontWeight: FontWeight.w500),
    labelMedium: GoogleFonts.roboto().copyWith(color: Colors.black54, fontWeight: FontWeight.normal)
  ),
  iconTheme: IconThemeData(
    color: AppColors.onSurfaceLight
  ),
  colorScheme: ColorScheme.light(
    surface: AppColors.surfaceVariantLight,
    onSecondary: AppColors.onSurfaceLight,
    primary: AppColors.primary,
    onPrimary: Colors.white
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.surfaceDark,
  appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      surfaceTintColor: Colors.transparent
  ),
  textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme).copyWith(
    displayLarge: GoogleFonts.roboto().copyWith(fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.roboto().copyWith(fontWeight: FontWeight.w500),
    labelMedium: GoogleFonts.roboto().copyWith(color: Colors.white60, fontWeight: FontWeight.normal)
  ),
  iconTheme: IconThemeData(
      color: AppColors.onSurfaceDark
  ),
  colorScheme: ColorScheme.dark(
    surface: AppColors.surfaceVariantDark,
    onSecondary: AppColors.onSurfaceDark,
    primary: AppColors.primary,
    onPrimary: Colors.white
  ),
);