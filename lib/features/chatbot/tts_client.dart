import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:queue/queue.dart';

class TextToSpeechClient {
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 1.0;
  double pitch = 1.0;
  double rate = 1.0;
  bool isCurrentLangugageInstalled = false;
  final taskQueue = Queue();

  TextToSpeechClient() {
    initTts();
  }

  void initTts() {
    flutterTts = FlutterTts();
    _setAwaitOptions();
    _getDefaultEngine();
    _getDefaultVoice();
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
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

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
