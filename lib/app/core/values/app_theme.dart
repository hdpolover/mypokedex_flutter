import 'package:flutter/material.dart';
// import google fonts
import 'package:google_fonts/google_fonts.dart';

import 'app_text_styles.dart';

abstract class AppTheme {
  static ThemeData appMainTheme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      titleLarge: GoogleFonts.roboto(
        textStyle: AppTextStyles.titleLarge,
      ),
      titleMedium: GoogleFonts.roboto(
        textStyle: AppTextStyles.titleMedium,
      ),
      bodySmall: GoogleFonts.roboto(
        textStyle: AppTextStyles.bodySmall,
      ),
      bodyMedium: GoogleFonts.roboto(
        textStyle: AppTextStyles.bodyMedium,
      ),
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
  );
}
