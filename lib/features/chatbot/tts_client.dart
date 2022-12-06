import 'dart:async';
import 'dart:developer';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextToSpeechClient {
  final voiceVolumeKey = 'chatbot-voice-volume';
  final voicePitchKey = 'chatbot-voice-pitch';
  final voiceRateKey = 'chatbot-voice-rate';

  static final TextToSpeechClient _instance = TextToSpeechClient._internal();
  TextToSpeechClient._internal() {
    // initSharedPreferences();
    initVoiceAttributes();
    initTts();
  }

  late SharedPreferences _preferences;
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  late double _volume;
  late double _pitch;
  late double _rate;

  double get volume => _volume;
  double get pitch => _pitch;
  double get rate => _rate;

  void setVolume(double volume) async {
    _volume = volume;
    await _preferences.setDouble(voiceVolumeKey, volume);
  }

  void setPitch(double pitch) async {
    _pitch = pitch;
    await _preferences.setDouble(voicePitchKey, pitch);
  }

  void setRate(double rate) async {
    _rate = rate;
    await _preferences.setDouble(voiceRateKey, rate);
  }

  factory TextToSpeechClient() {
    return _instance;
  }

  void initVoiceAttributes() async {
    _preferences = await SharedPreferences.getInstance();
    _volume = _preferences.getDouble(voiceVolumeKey) ?? 1.0;
    _pitch = _preferences.getDouble(voicePitchKey) ?? 1.0;
    _rate = _preferences.getDouble(voiceRateKey) ?? 0.7;
  }

  void initTts() {
    flutterTts = FlutterTts();
    _setAwaitOptions();
    _getDefaultEngine();
    _getDefaultVoice();

    flutterTts.setInitHandler(() {
      log('tts inted');
    });

    flutterTts.setErrorHandler((message) {
      log(message);
    });
  }

  Future<dynamic> getLanguages() async => await flutterTts.getLanguages;

  Future<dynamic> getEngines() async => await flutterTts.getEngines;

  Future _getDefaultEngine() async {
    await flutterTts.getDefaultEngine;
  }

  Future _getDefaultVoice() async {
    await flutterTts.getDefaultVoice;
  }

  Future speak(String content) async {
    await flutterTts.setVolume(_volume);
    await flutterTts.setSpeechRate(_rate);
    await flutterTts.setPitch(_pitch);

    if (content.isNotEmpty) {
      flutterTts.speak(content);
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(false);
  }

  Future stop() async {
    await flutterTts.stop();
  }

  Future pause() async {
    await flutterTts.pause();
  }

  Future dispose() async {
    await flutterTts.stop();
  }
}
