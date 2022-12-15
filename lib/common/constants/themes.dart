import 'dart:ui';

final List<DucktorTheme> ducktorThemes = [
  DefaultTheme(),
  Theme1(),
  Theme2(),
  Theme3(),
  Theme4(),
  Theme5(),
];

abstract class DucktorTheme {
  late String name;

  late Color primary;
  late Color onPrimary;
  late Color primaryDark;
  late Color background;
  late Color onBackground;
  late Color onBackgroundLight;
  late Color messageBoxBackground;
  late Color onMessageBoxBackground;
  late Color primaryMessageBoxBackground;
  late Color onPrimaryMessageBoxBackground;
  late Color suggestMessageBoxBackground;
  late Color onSuggestMessageBoxBackground;
  late Color suggestMessageBoxOutline;
  late Color suggestMessageBoxOverlay;
  late Color buttonOnMessageBoxBackground;
  late Color onButtonOnMessageBoxBackground;
  late Color typingDot;
  late Color flashingCircleDark;
  late Color flashingCircleBright;
  late Color ducktorBackground;
  late Color settingTileBackground;
}

class DefaultTheme extends DucktorTheme {
  DefaultTheme() {
    name = 'Default';

    primary = const Color(0xff00a6fb);
    onPrimary = const Color(0xffffffff);
    primaryDark = const Color(0xff0582CA);
    background = const Color(0xffFFFFFF);
    onBackground = const Color(0xff1a1a1a);
    onBackgroundLight = const Color(0xff777777);
    messageBoxBackground = const Color(0xffF4F4F4);
    onMessageBoxBackground = const Color(0xff424141);
    primaryMessageBoxBackground = primary;
    onPrimaryMessageBoxBackground = onPrimary;
    suggestMessageBoxBackground = const Color.fromARGB(255, 246, 246, 246);
    onSuggestMessageBoxBackground = const Color(0xff1a1a1a);
    suggestMessageBoxOutline = const Color.fromARGB(255, 243, 243, 243);
    suggestMessageBoxOverlay = const Color.fromARGB(255, 227, 227, 227);
    buttonOnMessageBoxBackground = const Color.fromARGB(255, 255, 255, 255);
    onButtonOnMessageBoxBackground = const Color.fromARGB(255, 104, 104, 104);
    typingDot = const Color.fromARGB(255, 204, 204, 204);
    flashingCircleDark = const Color.fromARGB(255, 167, 167, 167);
    flashingCircleBright = const Color.fromARGB(255, 238, 238, 238);
    ducktorBackground = const Color(0xfffbd200);
    settingTileBackground = const Color(0xffffffff);
  }
}

class Theme1 extends DucktorTheme {
  Theme1() {
    name = 'Lovely Pink';
    primary = const Color.fromARGB(255, 239, 89, 134);
    onPrimary = const Color(0xffffffff);
    primaryDark = const Color.fromARGB(255, 212, 61, 119);
    background = const Color.fromARGB(255, 255, 197, 218);
    onBackground = const Color(0xff1a1a1a);
    onBackgroundLight = const Color(0xff777777);
    messageBoxBackground = const Color(0xffFFFFFF);
    onMessageBoxBackground = const Color(0xff1a1a1a);
    primaryMessageBoxBackground = primary;
    onPrimaryMessageBoxBackground = onPrimary;
    suggestMessageBoxBackground = const Color(0xffFFFFFF);
    onSuggestMessageBoxBackground = const Color(0xff1a1a1a);
    suggestMessageBoxOutline = const Color.fromARGB(255, 243, 243, 243);
    suggestMessageBoxOverlay = const Color.fromARGB(255, 227, 227, 227);
    buttonOnMessageBoxBackground = const Color.fromARGB(255, 247, 247, 247);
    onButtonOnMessageBoxBackground = const Color.fromARGB(255, 98, 98, 98);
    typingDot = const Color.fromARGB(255, 204, 204, 204);
    flashingCircleDark = const Color.fromARGB(255, 167, 167, 167);
    flashingCircleBright = const Color.fromARGB(255, 238, 238, 238);
    ducktorBackground = const Color.fromARGB(255, 239, 89, 134);
    settingTileBackground = const Color(0xffffffff);
  }
}

class Theme2 extends DucktorTheme {
  Theme2() {
    name = 'Fresh Blue';
    primary = const Color.fromARGB(255, 150, 204, 251);
    onPrimary = const Color(0xffffffff);
    primaryDark = const Color.fromARGB(255, 116, 186, 252);
    background = const Color.fromARGB(255, 206, 232, 255);
    onBackground = const Color(0xff1a1a1a);
    onBackgroundLight = const Color(0xff777777);
    messageBoxBackground = const Color(0xffFFFFFF);
    onMessageBoxBackground = const Color(0xff1a1a1a);
    primaryMessageBoxBackground = primaryDark;
    onPrimaryMessageBoxBackground = onPrimary;
    suggestMessageBoxBackground = const Color(0xffFFFFFF);
    onSuggestMessageBoxBackground = const Color(0xff1a1a1a);
    suggestMessageBoxOutline = const Color.fromARGB(255, 243, 243, 243);
    suggestMessageBoxOverlay = const Color.fromARGB(255, 227, 227, 227);
    buttonOnMessageBoxBackground = const Color.fromARGB(255, 247, 247, 247);
    onButtonOnMessageBoxBackground = const Color.fromARGB(255, 98, 98, 98);
    typingDot = const Color.fromARGB(255, 204, 204, 204);
    flashingCircleDark = const Color.fromARGB(255, 167, 167, 167);
    flashingCircleBright = const Color.fromARGB(255, 238, 238, 238);
    ducktorBackground = primaryDark;
    settingTileBackground = const Color(0xffffffff);
  }
}

class Theme3 extends DucktorTheme {
  Theme3() {
    name = 'Pastel Pink';
    primary = const Color(0xffe5989b);
    onPrimary = const Color(0xffffffff);
    primaryDark = const Color.fromARGB(255, 198, 113, 130);
    background = const Color(0xffffb4a2);
    onBackground = const Color(0xff1a1a1a);
    onBackgroundLight = const Color(0xff777777);
    messageBoxBackground = const Color(0xffFFFFFF);
    onMessageBoxBackground = const Color(0xff1a1a1a);
    primaryMessageBoxBackground = primaryDark;
    onPrimaryMessageBoxBackground = onPrimary;
    suggestMessageBoxBackground = const Color(0xffFFFFFF);
    onSuggestMessageBoxBackground = const Color(0xff1a1a1a);
    suggestMessageBoxOutline = const Color.fromARGB(255, 243, 243, 243);
    suggestMessageBoxOverlay = const Color.fromARGB(255, 227, 227, 227);
    buttonOnMessageBoxBackground = const Color.fromARGB(255, 247, 247, 247);
    onButtonOnMessageBoxBackground = const Color.fromARGB(255, 98, 98, 98);
    typingDot = const Color.fromARGB(255, 204, 204, 204);
    flashingCircleDark = const Color.fromARGB(255, 167, 167, 167);
    flashingCircleBright = const Color.fromARGB(255, 238, 238, 238);
    ducktorBackground = primaryDark;
    settingTileBackground = const Color(0xffffffff);
  }
}

class Theme4 extends DucktorTheme {
  Theme4() {
    name = 'Mono Green';
    primary = const Color(0xff6a994e);
    onPrimary = const Color(0xffffffff);
    primaryDark = const Color(0xff386641);
    background = const Color(0xffa7c957);
    onBackground = const Color(0xff1a1a1a);
    onBackgroundLight = const Color(0xff777777);
    messageBoxBackground = const Color(0xffFFFFFF);
    onMessageBoxBackground = const Color(0xff1a1a1a);
    primaryMessageBoxBackground = primaryDark;
    onPrimaryMessageBoxBackground = onPrimary;
    suggestMessageBoxBackground = const Color(0xffFFFFFF);
    onSuggestMessageBoxBackground = const Color(0xff1a1a1a);
    suggestMessageBoxOutline = const Color.fromARGB(255, 243, 243, 243);
    suggestMessageBoxOverlay = const Color.fromARGB(255, 227, 227, 227);
    buttonOnMessageBoxBackground = const Color.fromARGB(255, 247, 247, 247);
    onButtonOnMessageBoxBackground = const Color.fromARGB(255, 98, 98, 98);
    typingDot = const Color.fromARGB(255, 204, 204, 204);
    flashingCircleDark = const Color.fromARGB(255, 167, 167, 167);
    flashingCircleBright = const Color.fromARGB(255, 238, 238, 238);
    ducktorBackground = primaryDark;
    settingTileBackground = const Color(0xffffffff);
  }
}

class Theme5 extends DucktorTheme {
  Theme5() {
    name = 'Mischievous Green';
    primary = const Color(0xff4c956c);
    onPrimary = const Color(0xffffffff);
    primaryDark = const Color(0xff2c6e49);
    background = const Color(0xfffefee3);
    onBackground = const Color(0xff1a1a1a);
    onBackgroundLight = const Color(0xff777777);
    messageBoxBackground = const Color.fromARGB(255, 242, 242, 222);
    onMessageBoxBackground = const Color(0xff1a1a1a);
    primaryMessageBoxBackground = primaryDark;
    onPrimaryMessageBoxBackground = onPrimary;
    suggestMessageBoxBackground = const Color.fromARGB(255, 242, 242, 222);
    onSuggestMessageBoxBackground = const Color(0xff1a1a1a);
    suggestMessageBoxOutline = const Color.fromARGB(255, 243, 243, 243);
    suggestMessageBoxOverlay = const Color.fromARGB(255, 227, 227, 227);
    buttonOnMessageBoxBackground = const Color.fromARGB(255, 247, 247, 247);
    onButtonOnMessageBoxBackground = const Color.fromARGB(255, 98, 98, 98);
    typingDot = const Color.fromARGB(255, 204, 204, 204);
    flashingCircleDark = const Color.fromARGB(255, 167, 167, 167);
    flashingCircleBright = const Color.fromARGB(255, 238, 238, 238);
    ducktorBackground = const Color.fromARGB(255, 88, 88, 73);
    settingTileBackground = const Color.fromARGB(255, 242, 242, 222);
  }
}
