import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:ducktor/common/utilities/message_action_utility.dart';
import 'package:ducktor/features/chatbot/model/location_data.dart';
import 'package:ducktor/features/chatbot/model/message.dart';
import 'package:ducktor/features/chatbot/viewmodel/chatbot_viewmodel.dart';
import 'package:ducktor/features/chatbot/widgets/expandable_widget.dart';
import 'package:ducktor/features/chatbot/widgets/speech_to_text_widget.dart';
import 'package:ducktor/features/chatbot/widgets/suggest_message_box.dart';
import 'package:ducktor/features/chatbot/widgets/typing_indicator.dart';
import 'package:ducktor/features/covid_info/covid_info_screen.dart';
import 'package:ducktor/features/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/constants/colors.dart';
import '../../common/constants/styles.dart';
import 'widgets/message_box.dart';
import 'widgets/message_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController controller = ScrollController();
  final TextEditingController textController = TextEditingController();
  List<Message> messages = [];
  final viewModel = ChatbotViewModel();

  late bool _expandedVoiceBox;
  late bool _initVoiceBox;

  @override
  void initState() {
    super.initState();
    loadChatHistory();
    connectToSocketIO();

    _expandedVoiceBox = false;
    _initVoiceBox = false;
  }

  @override
  void dispose() {
    controller.dispose();
    textController.dispose();
    viewModel.chatStream.dispose();
    viewModel.typingStream.dispose();
    viewModel.typingStream.dispose();
    viewModel.ttsClient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
          stream: viewModel.chatStream.getResponse,
          builder: (context, AsyncSnapshot<List<Message>> snapshot) {
            if (snapshot.hasData) {
              messages.insertAll(
                  0,
                  snapshot.data ??
                      [
                        Message(
                            id: UniqueKey().hashCode.toString(),
                            author: Author.server,
                            content: '',
                            dateTime: DateTime.now())
                      ]);
            }

            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                backgroundColor: AppColor.background,
                appBar: AppBar(
                  backgroundColor: AppColor.background,
                  elevation: 3,
                  title: Text(
                    "Ducktor",
                    style: AppTextStyle.semiBold18.copyWith(
                      color: AppColor.onBackground,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SettingScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: AppColor.onBackground,
                      ),
                    ),
                  ],
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: StreamBuilder<bool>(
                          stream: viewModel.typingStream.getEvent,
                          builder: (context, snapshot) {
                            bool typing = snapshot.data ?? false;

                            return Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                ListView.builder(
                                  reverse: true,
                                  controller: controller,
                                  padding: EdgeInsets.fromLTRB(
                                      8,
                                      8,
                                      8,
                                      viewModel.suggestMessages.isEmpty
                                          ? 24
                                          : 54),
                                  physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  ),
                                  itemCount: messages.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Visibility(
                                        visible: typing,
                                        child: const TypingIndicator(),
                                      );
                                    }
                                    return renderMessageBox(index - 1);
                                  },
                                ),
                                SizedBox(
                                  height: 60,
                                  child: ListView.builder(
                                    itemCount: viewModel.suggestMessages.length,
                                    itemBuilder: (_, index) {
                                      String suggestMessage =
                                          viewModel.suggestMessages[index];
                                      return SuggestMessageBox(
                                        message: suggestMessage,
                                        onPressed: () {
                                          textController.text = suggestMessage;
                                          textController.selection =
                                              TextSelection.fromPosition(
                                            TextPosition(
                                                offset:
                                                    textController.text.length),
                                          );
                                        },
                                      );
                                    },
                                    scrollDirection: Axis.horizontal,
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 10, 8, 10),
                                    physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    MessageTextField(
                      controller: textController,
                      onSendMessage: (message) {
                        handleSendMessage(message);

                        controller.animateTo(
                          0,
                          curve: Curves.linear,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      onMicTap: _expandedVoiceBox
                          ? null
                          : () {
                              setState(() {
                                if (!_initVoiceBox) {
                                  _initVoiceBox = true;
                                }
                                _expandedVoiceBox = true;
                              });
                            },
                    ),
                    if (_initVoiceBox)
                      ExpandableWidget(
                        expand: _expandedVoiceBox,
                        child: SpeechToTextWidget(
                          onClose: () {
                            setState(() {
                              _expandedVoiceBox = false;
                            });
                          },
                          onResult: (result) {
                            textController.text = result.recognizedWords;
                            textController.selection =
                                TextSelection.fromPosition(
                              TextPosition(offset: textController.text.length),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void handleSendMessage(String message) {
    viewModel.sendMessage(message);
  }

  Function()? getButtonHandlerByAction(MessageAction action,
      {LocationData? extraData}) {
    switch (action) {
      case MessageAction.getToCovidInfo:
        return () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CovidInfoScreen(),
            ),
          );
        };
      case MessageAction.getToMap:
        return () async {
          double lat = extraData!.location.lat;
          double lon = extraData.location.lon;
          String locationName = extraData.name;
          String address = extraData.address.toString();
          if (Platform.isAndroid) {
            Uri url = Uri.parse("geo:$lat,$lon?q=$locationName $address");

            AndroidIntent intent = AndroidIntent(
              action: 'action_view',
              data: url.toString(),
              package: 'com.google.android.apps.maps',
            );

            await intent.launch();
          } else if (Platform.isIOS) {
            Uri url = Uri.parse(
                "comgooglemaps://?q=$locationName $address&center=$lat,$lon");

            if (!await launchUrl(url)) {
              throw 'Could not launch $url';
            }
          }
        };
      case MessageAction.getToLocationSetting:
        return () {
          Geolocator.openLocationSettings();
        };
      default:
        return null;
    }
  }

  String getButtonLabelByAction(MessageAction action) {
    switch (action) {
      case MessageAction.getToMap:
        return "See on map";
      case MessageAction.getToLocationSetting:
        return "Open Settings";
      default:
        return "Tap here";
    }
  }

  MessageBox renderMessageBox(int index) {
    Message message = messages[index];
    Function()? buttonHandler =
        getButtonHandlerByAction(message.action, extraData: message.extraData);
    String buttonLabel = getButtonLabelByAction(message.action);

    if (!message.isClientMessage) {
      return MessageBox(
        time: message.dateTime.toString(),
        message: messages[index].content,
        showButton: buttonHandler != null,
        buttonHandler: buttonHandler,
        buttonContent: buttonLabel,
      );
    } else {
      return MessageBox(
        time: message.dateTime.toString(),
        message: messages[index].content,
        alignRight: true,
        highlight: true,
      );
    }
  }

  void connectToSocketIO() {
    viewModel.connectToSocketIO();
  }

  void loadChatHistory() {
    viewModel.loadChatHistory();
  }
}
