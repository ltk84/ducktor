import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/styles.dart';

class SuggestMessageBox extends StatelessWidget {
  final String message;
  final EdgeInsets margin;
  const SuggestMessageBox({
    super.key,
    required this.message,
    this.margin = const EdgeInsets.fromLTRB(4, 4, 4, 4),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
        onPressed: () {},
        style: AppButtonStyle.suggesstMessage(
          backgroundColor: AppColor.suggestMessageBoxBackground,
          foregroundColor: AppColor.onSuggestMessageBoxBackground,
          overlayColor: AppColor.suggestMessageBoxOverlay,
          outlineColor: AppColor.suggestMessageBoxOutlineColor,
        ),
        child: Text(
          message,
        ),
      ),
    );
  }
}
