import 'package:ducktor/common/utilities/message_action_utility.dart';
import 'package:ducktor/features/chatbot/model/message.dart';
import 'package:ducktor/features/chatbot/viewmodel/chatbot_viewmodel.dart';
import 'package:ducktor/features/chatbot/widgets/suggest_message_box.dart';
import 'package:ducktor/features/covid_info/covid_info_screen.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    loadChatHistory();
    connectToSocketIO();
  }

  @override
  void dispose() {
    controller.dispose();
    textController.dispose();
    viewModel.chatStream.dispose();
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
                  elevation: 0.5,
                  title: Text(
                    "Ducktor",
                    style: AppTextStyle.semiBold18.copyWith(
                      color: AppColor.onBackground,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          ListView.builder(
                            reverse: true,
                            controller: controller,
                            padding: EdgeInsets.fromLTRB(8, 8, 8,
                                viewModel.suggestMessages.isEmpty ? 24 : 54),
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return renderMessageBox(index);
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
                                  },
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Function()? getButtonHandlerByAction(MessageAction action) {
    switch (action) {
      case MessageAction.none:
        return null;
      case MessageAction.getToCovidInfo:
        return () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CovidInfoScreen(),
            ),
          );
        };
    }
  }

  MessageBox renderMessageBox(int index) {
    Message message = messages[index];

    if (!message.isClientMessage) {
      return MessageBox(
        time: message.dateTime.toString(),
        message: messages[index].content,
        showButton: message.action != MessageAction.none,
        buttonHandler: getButtonHandlerByAction(message.action),
        // showButton: true,
        // buttonHandler: () async {
        //   double lat = 10.77134;
        //   double lon = 106.629766;
        //   String locationName = "Tiệm Sửa Xe Phước";
        //   String address = "61 Cây keo";
        //   if (Platform.isAndroid) {
        //     Uri url = Uri.parse("geo:$lat,$lon?q=$locationName $address");

        //     AndroidIntent intent = AndroidIntent(
        //       action: 'action_view',
        //       data: url.toString(),
        //       package: 'com.google.android.apps.maps',
        //     );

        //     await intent.launch();
        //   } else if (Platform.isIOS) {
        //     Uri url = Uri.parse(
        //         "comgooglemaps://?q=$locationName $address&center=$lat,$lon");

        //     if (!await launchUrl(url)) {
        //       throw 'Could not launch $url';
        //     }
        //   }
        // },
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
