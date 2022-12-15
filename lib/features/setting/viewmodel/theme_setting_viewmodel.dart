import 'package:ducktor/common/utilities/theme_provider.dart';

class ThemeSettingViewModel {
  late int selectedThemeIndex;

  ThemeSettingViewModel() {
    selectedThemeIndex = DucktorThemeProvider.themeIndex;
  }

  changeTheme(index) {
    DucktorThemeProvider.changeTheme(index);
    selectedThemeIndex = index;
  }
}
