import 'package:ducktor/common/constants/colors.dart';
import 'package:ducktor/features/setting/chatbot_voice_setting.dart';
import 'package:ducktor/features/setting/widgets/setting_tile.dart';
import 'package:flutter/material.dart';

import '../../common/constants/styles.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Settings",
            style: AppTextStyle.semiBold18.copyWith(
              color: AppColor.onBackground,
            ),
          ),
          centerTitle: true,
          leading: const BackButton(
            color: AppColor.onBackground,
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
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const ChatbotVoiceSetting(),
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
                onTap: () {},
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
