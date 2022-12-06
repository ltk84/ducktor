class AppString {
  AppString._();

  static const String messageBoxHintText = "Type message here";
  static const String askGrantPermission = "Please grant microphone permission";
  static const String askGrantPermissionManually =
      "No permission to record, please grant microphone permission in Settings";

  static const String errorSpeechTimeOut = "Can't hear your voice";
  static const String errorNoMatch = "Can't recognize what you've said";
  static const String voiceErrorDefault = "Can't recognize your voice";
  static const String listening = "Listening...";
  static const String tapMicToStart = "Tap the microphone to start";
}

class EndpointString {
  EndpointString._();
  static const String covidInfoBase = "/covid";
  static const String getSummaryInfo = "/get-summary";
}
