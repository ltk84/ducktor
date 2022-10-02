import 'package:flutter/material.dart';

import 'common/constants/colors.dart';
import 'common/constants/styles.dart';
import 'widgets/message_box.dart';
import 'widgets/message_text_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  children: const [
                    MessageBox(
                      senderName: "Ducktor",
                      time: "3:00 AM",
                      message:
                          "Xin chào, tôi là Vịt Sĩ! Tôi có thể giúp gì cho bạn?",
                    ),
                    MessageBox(
                      senderName: "Ducktor",
                      alignRight: true,
                      time: "3:01 AM",
                      message: "Tôi bị Covid",
                      highlight: true,
                    ),
                    MessageBox(
                      senderName: "Ducktor",
                      time: "3:30 AM",
                      message: "Kệ bạn",
                    ),
                  ],
                ),
              ),
              const MessageTextField(),
            ],
          ),
        ),
      ),
    );
  }
}
