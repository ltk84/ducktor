import 'dart:io';
import 'dart:ui';

import 'package:android_intent_plus/android_intent.dart';
import 'package:ducktor/common/constants/assets.dart';
import 'package:ducktor/common/utilities/message_action_utility.dart';
import 'package:ducktor/features/chatbot/model/location_data.dart';
import 'package:ducktor/features/chatbot/model/message.dart';
import 'package:ducktor/features/chatbot/viewmodel/chatbot_viewmodel.dart';
import 'package:ducktor/features/chatbot/widgets/expandable_widget.dart';
import 'package:ducktor/features/chatbot/widgets/speech_to_text_widget.dart';
import 'package:ducktor/features/chatbot/widgets/suggest_message_box.dart';
import 'package:ducktor/features/chatbot/widgets/typing_indicator.dart';
import 'package:ducktor/features/covid_info/covid_info_screen.dart';
import 'package:ducktor/features/reminder/reminder_client.dart';
import 'package:ducktor/features/reminder/model/reminder_setting.dart';
import 'package:ducktor/features/reminder/reminder_screen.dart';
import 'package:ducktor/features/reminder/widgets/reminder_setting_dialog.dart';
import 'package:ducktor/features/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/utilities/theme_provider.dart';
import '../../common/constants/styles.dart';
import 'widgets/message_box.dart';
import 'widgets/message_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final remiderClient = ReminderClient();

  final ScrollController controller = ScrollController();
  final TextEditingController textController = TextEditingController();
  List<Message> messages = [];
  final viewModel = ChatbotViewModel();

  late bool _expandedVoiceBox;
  late bool _initVoiceBox;
  late bool _stateChanged;

  @override
  void initState() {
    super.initState();
    loadChatHistory();
    connectToSocketIO();

    _stateChanged = false;
    _expandedVoiceBox = false;
    _initVoiceBox = false;

    remiderClient.isAndroidPermissionGranted();
    remiderClient.requestPermission();
    remiderClient.configureDidReceiveLocalNotificationSubject();
    remiderClient.configureSelectNotificationSubject();
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
    return StreamBuilder(
        stream: viewModel.chatStream.getResponse,
        builder: (context, AsyncSnapshot<List<Message>> snapshot) {
          if (!_stateChanged) {
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
          } else {
            _stateChanged = false;
          }

          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: DucktorThemeProvider.background,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 80,
                flexibleSpace: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 36, sigmaY: 36),
                    child: Container(
                      color: DucktorThemeProvider.background.withOpacity(0.64),
                    ),
                  ),
                ),
                title: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: DucktorThemeProvider.ducktorBackground,
                        backgroundImage: const AssetImage(AppAsset.duckFace),
                      ),
                    ),
                    Text(
                      "Ducktor",
                      style: AppTextStyle.semiBold16.copyWith(
                        color: DucktorThemeProvider.onBackground,
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: ReminderScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.schedule_rounded,
                      color: DucktorThemeProvider.onBackground,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      bool themeChanged = await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: const SettingScreen(),
                        ),
                      );
                      if (themeChanged) {
                        setState(() {
                          _stateChanged = true;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.settings,
                      color: DucktorThemeProvider.onBackground,
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
                                    108,
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
                                        final currentText = textController.text;
                                        if (currentText.endsWith(' ')) {
                                          textController.text +=
                                              '$suggestMessage ';
                                        } else {
                                          textController.text =
                                              '$suggestMessage ';
                                        }
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
                              _stateChanged = true;
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
                            _stateChanged = true;
                          });
                        },
                        onResult: (result) {
                          textController.text = result.recognizedWords;
                          textController.selection = TextSelection.fromPosition(
                            TextPosition(offset: textController.text.length),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        });
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
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: const CovidInfoScreen(),
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
      case MessageAction.openReminderSetting:
        return () async {
          final result = await showDialog(
            context: context,
            builder: ((context) => const ReminderSettingDialog()),
          );
          if (result != null) {
            final timeline = await remiderClient.createReminder(
              title: result['title'],
              body: result['message'],
              setting: result['setting'],
            );

            viewModel.addReminderInfo(
                result['title'], result['message'], timeline);

            DateTime beginDate =
                (result['setting'] as ReminderSetting).fromDate;
            viewModel.sendServerMessage(
              'Reminder for "${result['title']}" has been set successfully! The next notification will be at ${DateFormat('HH:mm').format(beginDate)} on ${DateFormat('dd-MM-yyyy').format(beginDate)}. You can check the full notification list here.',
              action: MessageAction.openNotiReminderList,
            );
          }
        };
      case MessageAction.openNotiReminderList:
        return () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: ReminderScreen(),
            ),
          );
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
      case MessageAction.openReminderSetting:
        return "Set Reminder";
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
