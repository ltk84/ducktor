import 'dart:math';

import 'package:flutter/material.dart';

import 'common/constants/colors.dart';
import 'common/constants/styles.dart';
import 'widgets/message_box.dart';
import 'widgets/message_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController controller = ScrollController();
  List<String> duckBark = [
    "Xin chào, tôi là Vịt Sĩ! Tôi có thể giúp gì cho bạn?",
    "Là sao?",
    "Kệ bạn",
    "Cút hộ",
    "Ai gảnh",
  ];
  List<String> messages = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
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
                    String message = messages[index];

                    if (duckBark.contains(message)) {
                      return MessageBox(
                        time: DateTime.now().toString(),
                        message: messages[index],
                      );
                    } else {
                      return MessageBox(
                        time: DateTime.now().toString(),
                        message: messages[index],
                        alignRight: true,
                        highlight: true,
                      );
                    }
                  },
                ),
              ),
              MessageTextField(
                onSendMessage: (message) {
                  setState(() {
                    messages.insert(0, message);
                    Random randomBarkIndex = Random();
                    messages.insert(
                        0, duckBark[randomBarkIndex.nextInt(duckBark.length)]);
                  });

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
      ),
    );
  }
}
