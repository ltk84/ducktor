import 'package:android_intent_plus/android_intent.dart';
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
        onPressed: () async {
          // Uri a = Uri.parse(
          //     "geo:10.77134,106.629766?q=Tiệm Sửa Xe Phước 61 Cây keo");
          // AndroidIntent intent = AndroidIntent(
          //   action: 'action_view',
          //   data: a.toString(),
          //   package: 'com.google.android.apps.maps',
          // );
          // await intent.launch();
        },
        style: AppButtonStyle.suggesstMessage(
          backgroundColor: AppColor.suggestMessageBoxBackground,
          foregroundColor: AppColor.onSuggestMessageBoxBackground,
          overlayColor: AppColor.suggestMessageBoxOverlay,
          outlineColor: AppColor.suggestMessageBoxOutline,
        ),
        child: Text(
          message,
        ),
      ),
    );
  }
}
