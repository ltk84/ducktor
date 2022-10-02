import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle bold16 = GoogleFonts.beVietnamPro(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle regular16 = GoogleFonts.beVietnamPro(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle regular12 = GoogleFonts.beVietnamPro(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}

class AppButtonStyle {
  AppButtonStyle._();
}

class AppGeneralStyle {
  AppGeneralStyle._();

  static BorderRadius messageBoxBorderRadius = BorderRadius.circular(12);
  static EdgeInsets messageBoxPadding =
      const EdgeInsets.fromLTRB(12, 12, 12, 12);
  static EdgeInsets messageBoxMargin = const EdgeInsets.fromLTRB(8, 8, 8, 8);
}
