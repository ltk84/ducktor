import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle semiBold16 = GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle semiBold18 = GoogleFonts.notoSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bold24 = GoogleFonts.notoSans(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static TextStyle black18 = GoogleFonts.notoSans(
    fontSize: 18,
    fontWeight: FontWeight.w900,
  );

  static TextStyle regular18 = GoogleFonts.notoSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static TextStyle regular16 = GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle regular12 = GoogleFonts.notoSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle regular14 = GoogleFonts.notoSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}

class AppButtonStyle {
  AppButtonStyle._();
  static ButtonStyle suggesstMessage({
    required Color backgroundColor,
    required Color foregroundColor,
    Color overlayColor = const Color.fromARGB(255, 227, 227, 227),
    Color outlineColor = const Color.fromARGB(255, 243, 243, 243),
  }) {
    return ButtonStyle(
      textStyle: MaterialStatePropertyAll<TextStyle?>(
        AppTextStyle.regular16,
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return foregroundColor.withOpacity(0.8);
          } else {
            return foregroundColor;
          }
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return backgroundColor;
          } else {
            return backgroundColor;
          }
        },
      ),
      elevation: MaterialStateProperty.all(0),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
          side: BorderSide.none,
        ),
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return overlayColor;
          } else {
            return backgroundColor;
          }
        },
      ),
    );
  }

  static ButtonStyle elevated({
    required Color backgroundColor,
    required Color foregroundColor,
    Color overlayColor = const Color.fromARGB(255, 227, 227, 227),
    double radius = 16.0,
  }) {
    return ButtonStyle(
      textStyle: MaterialStatePropertyAll<TextStyle?>(
        AppTextStyle.semiBold16,
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return foregroundColor.withOpacity(0.8);
          } else {
            return foregroundColor;
          }
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return backgroundColor;
          } else {
            return backgroundColor;
          }
        },
      ),
      elevation: MaterialStateProperty.resolveWith<double?>((states) {
        if (states.contains(MaterialState.pressed)) {
          return 1;
        } else {
          return 0;
        }
      }),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide.none,
        ),
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return overlayColor;
          } else {
            return backgroundColor;
          }
        },
      ),
    );
  }

  static ButtonStyle text({
    required Color foregroundColor,
    Color overlayColor = const Color.fromARGB(50, 227, 227, 227),
  }) {
    return ButtonStyle(
      textStyle: MaterialStatePropertyAll<TextStyle?>(
        AppTextStyle.semiBold16,
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return foregroundColor.withOpacity(0.8);
          } else {
            return foregroundColor;
          }
        },
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide.none,
        ),
      ),
      overlayColor: MaterialStateProperty.all(overlayColor),
    );
  }
}
