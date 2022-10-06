import 'package:flutter/material.dart';

import '../common/constants/assets.dart';
import '../common/constants/colors.dart';
import '../common/constants/styles.dart';
import '../common/constants/strings.dart';

class MessageTextField extends StatelessWidget {
  final Function(String message) onSendMessage;
  const MessageTextField({
    super.key,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Container(
      color: AppColor.primary,
      padding: const EdgeInsets.fromLTRB(8, 12, 4, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TextFormField(
              controller: controller,
              cursorColor: AppColor.onPrimary,
              style: AppTextStyle.regular16.copyWith(
                color: AppColor.onPrimary,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                ),
                filled: true,
                fillColor: AppColor.primaryDark,
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
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (controller.text.isNotEmpty) {
                  onSendMessage(controller.text);
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
