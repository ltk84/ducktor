import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/features/setting/chatbot_voice_setting.dart';
import 'package:ducktor/features/setting/theme_setting.dart';
import 'package:ducktor/features/setting/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../common/constants/styles.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late bool _themeChanged;

  @override
  void initState() {
    _themeChanged = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: DucktorThemeProvider.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Settings",
            style: AppTextStyle.semiBold18.copyWith(
              color: DucktorThemeProvider.onBackground,
            ),
          ),
          centerTitle: true,
          leading: BackButton(
            color: DucktorThemeProvider.onBackground,
            onPressed: () {
              Navigator.of(context).pop(_themeChanged);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingTile(
                label: 'Chatbot Voice',
                iconData: Icons.record_voice_over_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: const ChatbotVoiceSetting(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              SettingTile(
                label: 'Theme',
                iconData: Icons.color_lens_rounded,
                onTap: () async {
                  bool themeChanged = await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: const ThemeSetting(),
                    ),
                  );
                  if (themeChanged) {
                    setState(() {
                      _themeChanged = true;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
