import 'package:ducktor/common/constants/themes.dart';
import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/common/constants/styles.dart';
import 'package:ducktor/features/setting/viewmodel/theme_setting_viewmodel.dart';
import 'package:ducktor/features/setting/widgets/theme_tile.dart';
import 'package:flutter/material.dart';

class ThemeSetting extends StatefulWidget {
  const ThemeSetting({super.key});

  @override
  State<ThemeSetting> createState() => _ThemeSettingState();
}

class _ThemeSettingState extends State<ThemeSetting> {
  final viewModel = ThemeSettingViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DucktorThemeProvider.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Theme",
          style: AppTextStyle.semiBold18.copyWith(
            color: DucktorThemeProvider.onBackground,
          ),
        ),
        centerTitle: true,
        leading: BackButton(
            color: DucktorThemeProvider.onBackground,
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ThemeTile(
                label: ducktorThemes[index].name,
                primary: ducktorThemes[index].primary,
                background: ducktorThemes[index].background,
                onPrimary: ducktorThemes[index].onPrimary,
                onTap: () {
                  setState(() {
                    viewModel.changeTheme(index);
                  });
                },
                check: viewModel.selectedThemeIndex == index,
              ),
            );
          },
        ),
      ),
    );
  }
}
