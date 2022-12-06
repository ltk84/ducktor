import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:ducktor/common/constants/colors.dart';
import 'package:ducktor/common/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextWidget extends StatefulWidget {
  final Function(SpeechRecognitionResult)? onResult;
  final Function()? onClose;
  const SpeechToTextWidget({super.key, this.onResult, this.onClose});

  @override
  State<SpeechToTextWidget> createState() => _SpeechToTextWidgetState();
}

class _SpeechToTextWidgetState extends State<SpeechToTextWidget> {
  late SpeechToText _speechToText;
  late bool _available;
  late String _statusMessage;
  late bool _tryPermit;

  @override
  void initState() {
    super.initState();
    _tryPermit = true;
    _available = false;
    _statusMessage = 'Please grant microphone permission';
    _initSpeech();
  }

  void _initSpeech() async {
    _speechToText = SpeechToText();
    _available = await _speechToText.initialize(
      onStatus: (status) => {
        setState(() {
          switch (status) {
            case "listening":
              _statusMessage = 'Listening...';
              break;
            default:
              _statusMessage = 'Tap the microphone to start';
              break;
          }
        })
      },
      onError: (error) => {
        print(error),
        setState(() {
          switch (error.errorMsg) {
            case "error_speech_timeout":
              _statusMessage = 'Can\'t hear your voice';
              break;
            case "error_no_match":
              _statusMessage = 'Can\'t recognize what you\'ve said';
              break;
            case "error_permission":
              _statusMessage =
                  'No permission to record, please grant microphone permission in Settings';
              break;
            default:
              _statusMessage = 'Can\'t recognize your voice';
              break;
          }
        })
      },
    );

    // var locales = await _speechToText.locales();

    // for (LocaleName e in locales) {
    //   print(e.name + " " + e.localeId);
    // }
    if (!_available) {
      setState(() {
        if (_tryPermit) {
          _statusMessage =
              'No permission to record, please grant microphone permission in Settings';
          _tryPermit = false;
        } else {
          _statusMessage = 'Please grant microphone permission';
          _tryPermit = true;
        }
      });
    } else {
      setState(() {
        _statusMessage = 'Tap the microphone to start';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColor.primary,
      alignment: Alignment.center,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _stopListen();
                    if (widget.onClose != null) {
                      widget.onClose!();
                    }
                  },
                  borderRadius: BorderRadius.circular(100.0),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: const Icon(
                      Icons.close_rounded,
                      color: AppColor.onPrimary,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: AvatarGlow(
                  animate: _speechToText.isListening,
                  glowColor: AppColor.onPrimary,
                  endRadius: 36.0,
                  duration: const Duration(milliseconds: 2000),
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  repeat: true,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTapDown: (details) =>
                          _available ? _startListen() : null,
                      onTapUp: (details) => _available ? _stopListen() : null,
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(
                        margin: const EdgeInsets.all(16.0),
                        child: Icon(
                          _available
                              ? (_speechToText.isListening
                                  ? Icons.mic_rounded
                                  : Icons.mic_none_rounded)
                              : Icons.mic_off_rounded,
                          color: AppColor.onPrimary
                              .withOpacity(_available ? 1.0 : 0.5),
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Text(
                  _statusMessage,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular16
                      .copyWith(color: AppColor.onPrimary),
                ),
              ),
              if (!_available)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_tryPermit) {
                        _initSpeech();
                      } else {
                        openAppSettings();
                        setState(() {
                          _statusMessage = 'Please grant microphone permission';
                          _tryPermit = true;
                        });
                      }
                    },
                    style: AppButtonStyle.elevated(
                      backgroundColor: AppColor.background,
                      foregroundColor: AppColor.onBackground,
                    ),
                    child: Text(_tryPermit ? 'Try again' : 'Open Settings'),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _startListen() async {
    if (!_speechToText.isListening) {
      if (_available) {
        await _speechToText.listen(
            // localeId: 'vi_VN',
            localeId: 'en_US',
            listenFor: const Duration(seconds: 30),
            pauseFor: const Duration(seconds: 10),
            onResult: widget.onResult,
            listenMode: ListenMode.dictation);
      }
    }
  }

  void _stopListen() async {
    if (_speechToText.isListening) {
      await _speechToText.stop();
    }
  }
}
