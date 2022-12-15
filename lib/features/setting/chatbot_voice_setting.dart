import 'package:ducktor/features/setting/viewmodel/chatbot_voice_setting_viewmodel.dart';
import 'package:ducktor/features/setting/widgets/slider_setting.dart';
import 'package:flutter/material.dart';

import '../../common/utilities/theme_provider.dart';
import '../../common/constants/styles.dart';

class ChatbotVoiceSetting extends StatefulWidget {
  const ChatbotVoiceSetting({super.key});

  @override
  State<ChatbotVoiceSetting> createState() => _ChatbotVoiceSettingState();
}

class _ChatbotVoiceSettingState extends State<ChatbotVoiceSetting> {
  final viewModel = ChatbotVoiceSettingViewModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: DucktorThemeProvider.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Chatbot Voice",
            style: AppTextStyle.semiBold18.copyWith(
              color: DucktorThemeProvider.onBackground,
            ),
          ),
          centerTitle: true,
          leading: BackButton(
            color: DucktorThemeProvider.onBackground,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SliderSetting(
              initialValue: viewModel.getVolume(),
              label: 'Volume',
              onChange: viewModel.handleChangeVolume,
            ),
            const SizedBox(
              height: 24,
            ),
            SliderSetting(
              min: 0.5,
              max: 2.0,
              initialValue: viewModel.getPitch(),
              label: 'Pitch',
              onChange: viewModel.handleChangePitch,
            ),
            const SizedBox(
              height: 24,
            ),
            SliderSetting(
              initialValue: viewModel.getRate(),
              label: 'Rate',
              onChange: viewModel.handleChangeRate,
            ),
          ],
        ),
      ),
    );
  }
}
