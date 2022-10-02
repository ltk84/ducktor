import 'package:flutter/material.dart';

import '../constants/assets.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primary,
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TextFormField(
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
                hintText: "Write a message",
              ),
              maxLines: 5,
              minLines: 1,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
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
