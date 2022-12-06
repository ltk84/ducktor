import 'package:ducktor/features/chatbot/tts_client.dart';

class ChatbotVoiceSettingViewModel {
  late TextToSpeechClient ttsClient;

  ChatbotVoiceSettingViewModel() {
    ttsClient = TextToSpeechClient();
  }

  double getVolume() {
    return ttsClient.volume;
  }

  double getPitch() {
    return ttsClient.pitch;
  }

  double getRate() {
    return ttsClient.rate;
  }

  void handleChangeVolume(value) {
    ttsClient.setVolume(value);
  }

  void handleChangePitch(value) {
    ttsClient.setPitch(value);
  }

  void handleChangeRate(value) {
    ttsClient.setRate(value);
  }
}
