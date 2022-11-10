import 'dart:developer';

import 'package:ducktor/features/chatbot/chat_stream.dart';
import 'package:ducktor/features/chatbot/message.dart';
import 'package:ducktor/features/chatbot/models/response.dart';
import 'package:ducktor/features/chatbot/widgets/suggest_message_box.dart';
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

  String currentEvent = 'message';

  void connectToSocketIO() {
    socket.onConnect((data) => log('Client connected!'));
    socket.onDisconnect((data) => log('Client disconnect!'));
    socket.onConnectError((data) => log('error $data'));
    socket.onConnecting((data) => log('connecting...'));
    socket.onConnectTimeout((data) => log('timeout'));

    socket.on(currentEvent, (data) {
      final response = Response.fromMap(data);
      if (response.nextEvent.isNotEmpty && currentEvent != response.nextEvent) {
        currentEvent = response.nextEvent;
      }
      log('Client receive: ${response.toString()}');
      _chatStream.addResponse(
          Message(author: Author.server, content: response.content));
    });

    // socket.on(SocketIOEvent.diseasePrediction, (data) {
    //   final response = Response.fromMap(data);
    //   if (response.nextEvent.isNotEmpty && currentEvent != response.nextEvent) {
    //     currentEvent = response.nextEvent;
    //   }
    //   _chatStream.addResponse(
    //       Message(author: Author.server, content: response.content));
    // });

    // socket.on(SocketIOEvent.receiveSymptoms, (data) {
    //   final response = Response.fromMap(data);
    //   if (response.nextEvent.isNotEmpty && currentEvent != response.nextEvent) {
    //     currentEvent = response.nextEvent;
    //   }
    //   _chatStream.addResponse(
    //       Message(author: Author.server, content: response.content));
    // });

    // socket.on(SocketIOEvent.diseaseInformation, (data) {
    //   final response = Response.fromMap(data);
    //   if (response.nextEvent.isNotEmpty && currentEvent != response.nextEvent) {
    //     currentEvent = response.nextEvent;
    //   }
    //   log(response.toString());
    //   _chatStream.addResponse(
    //       Message(author: Author.server, content: response.content));
    // });
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
                    Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            children: const [
                              SuggestMessageBox(message: 'Hello'),
                              SuggestMessageBox(message: 'Hi'),
                              SuggestMessageBox(message: 'Alo'),
                            ],
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
    _chatStream.addResponse(Message(author: Author.client, content: message));
    socket.emit(currentEvent, message);
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
