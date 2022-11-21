import 'package:ducktor/features/chatbot/model/message.dart';
import 'package:ducktor/features/chatbot/viewmodel/chatbot_viewmodel.dart';
import 'package:ducktor/features/chatbot/widgets/suggest_message_box.dart';
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
                      child: ListView.builder(
                        reverse: true,
                        controller: controller,
                        padding: const EdgeInsets.all(8.0),
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return renderMessageBox(index);
                        },
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            itemCount: viewModel.suggestMessages.length,
                            itemBuilder: (_, index) => SuggestMessageBox(
                                message: viewModel.suggestMessages[index]),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                          ),
                        ),
                        MessageTextField(
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

  MessageBox renderMessageBox(int index) {
    Message message = messages[index];

    if (!message.isClientMessage) {
      return MessageBox(
        time: message.dateTime.toString(),
        message: messages[index].content,
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
