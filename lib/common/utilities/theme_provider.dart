import 'dart:ui';

import 'package:ducktor/common/constants/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DucktorThemeProvider {
  static late SharedPreferences _prefs;
  static DucktorTheme _theme = ducktorThemes[0];
  static int themeIndex = 0;

  static Color get primary => _theme.primary;
  static Color get onPrimary => _theme.onPrimary;
  static Color get primaryDark => _theme.primaryDark;
  static Color get background => _theme.background;
  static Color get onBackground => _theme.onBackground;
  static Color get onBackgroundLight => _theme.onBackgroundLight;
  static Color get messageBoxBackground => _theme.messageBoxBackground;
  static Color get onMessageBoxBackground => _theme.onMessageBoxBackground;
  static Color get primaryMessageBoxBackground =>
      _theme.primaryMessageBoxBackground;
  static Color get onPrimaryMessageBoxBackground =>
      _theme.onPrimaryMessageBoxBackground;
  static Color get suggestMessageBoxBackground =>
      _theme.suggestMessageBoxBackground;
  static Color get onSuggestMessageBoxBackground =>
      _theme.onSuggestMessageBoxBackground;
  static Color get suggestMessageBoxOutline => _theme.suggestMessageBoxOutline;
  static Color get suggestMessageBoxOverlay => _theme.suggestMessageBoxOverlay;
  static Color get buttonOnMessageBoxBackground =>
      _theme.buttonOnMessageBoxBackground;
  static Color get onButtonOnMessageBoxBackground =>
      _theme.onButtonOnMessageBoxBackground;
  static Color get typingDot => _theme.typingDot;
  static Color get flashingCircleDark => _theme.flashingCircleDark;
  static Color get flashingCircleBright => _theme.flashingCircleBright;
  static Color get ducktorBackground => _theme.ducktorBackground;
  static Color get settingTileBackground => _theme.settingTileBackground;
  static Color get reminderTileBackground => _theme.reminderTileBackground;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    themeIndex = _prefs.getInt('theme') ?? 0;
    _theme = ducktorThemes[themeIndex];
  }

  static void changeTheme(index) {
    _theme = ducktorThemes[index];
    DucktorThemeProvider.themeIndex = index;
    _prefs.setInt('theme', index);
  }
}
