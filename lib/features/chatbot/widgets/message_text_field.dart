import 'package:flutter/material.dart';

import '../../../common/constants/assets.dart';
import '../../../common/utilities/theme_provider.dart';
import '../../../common/constants/styles.dart';
import '../../../common/constants/strings.dart';

class MessageTextField extends StatelessWidget {
  final Function(String message) onSendMessage;
  final Function()? onMicTap;
  final TextEditingController controller;
  const MessageTextField({
    super.key,
    required this.onSendMessage,
    required this.controller,
    this.onMicTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DucktorThemeProvider.primary,
      padding: const EdgeInsets.fromLTRB(8, 12, 4, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TextFormField(
              controller: controller,
              cursorColor: DucktorThemeProvider.onPrimary,
              style: AppTextStyle.regular16.copyWith(
                color: DucktorThemeProvider.onPrimary,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                ),
                filled: true,
                fillColor: DucktorThemeProvider.primaryDark,
                contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                isDense: true,
                hintText: AppString.messageBoxHintText,
              ),
              maxLines: 5,
              minLines: 1,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          if (onMicTap != null)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onMicTap,
                borderRadius: BorderRadius.circular(12.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.mic_rounded,
                    color: DucktorThemeProvider.onPrimary,
                  ),
                ),
              ),
            ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (controller.text.isNotEmpty) {
                  onSendMessage(controller.text);
                  controller.text = "";
                }
              },
              borderRadius: BorderRadius.circular(12.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  AppAsset.send,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
