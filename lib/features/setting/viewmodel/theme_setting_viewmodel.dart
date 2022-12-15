import 'package:ducktor/common/constants/themes.dart';
import 'package:ducktor/common/utilities/theme_provider.dart';

class ThemeSettingViewModel {
  late int selectedThemeIndex;

  List<DucktorTheme> themes = [
    DefaultTheme(),
    Theme1(),
    Theme2(),
    Theme3(),
    Theme4(),
    Theme5(),
  ];

  ThemeSettingViewModel() {
    selectedThemeIndex = DucktorThemeProvider.themeIndex;
  }

  changeTheme(index) {
    DucktorThemeProvider.changeTheme(index);
    selectedThemeIndex = index;
  }
}
