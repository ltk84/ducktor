import 'package:ducktor/features/chatbot/chat_stream.dart';
import 'package:ducktor/features/chatbot/message.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

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

  final ChatStream _chatStream = ChatStream();
  // Change to your PC's IPv4
  final Socket socket = io('http://192.168.1.85:5004/',
      OptionBuilder().setTransports(['websocket']).build());

  void connectToSocketIO() {
    socket.onConnect((data) => print('Client connected!'));

    socket.onDisconnect((data) => print('Client disconnect!'));

    socket.onConnectError((data) => print('error $data'));

    socket.onConnecting((data) => print('connecting...'));

    socket.onConnectTimeout((data) => print('timeout'));

    socket.on('message', (data) {
      _chatStream.addResponse(Message(author: Author.server, content: data));
    });
  }

  @override
  void initState() {
    super.initState();
    connectToSocketIO();
  }

  @override
  void dispose() {
    controller.dispose();
    _chatStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
          stream: _chatStream.getResponse,
          builder: (context, AsyncSnapshot<Message> snapshot) {
            if (snapshot.hasData) {
              messages.insert(0,
                  snapshot.data ?? Message(author: Author.server, content: ''));
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
              ),
            );
          }),
    );
  }

  void handleSendMessage(String message) {
    messages.insert(0, Message(author: Author.client, content: message));
    socket.send([message]);
  }

  MessageBox renderMessageBox(int index) {
    Message message = messages[index];

    if (!message.isClientMessage) {
      return MessageBox(
        time: DateTime.now().toString(),
        message: messages[index].content,
      );
    } else {
      return MessageBox(
        time: DateTime.now().toString(),
        message: messages[index].content,
        alignRight: true,
        highlight: true,
      );
    }
  }
}
