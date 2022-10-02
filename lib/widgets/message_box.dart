import 'package:ducktor/constants/colors.dart';
import 'package:ducktor/constants/styles.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String? senderName;
  final String time;
  final String message;
  final bool alignRight;
  final double widthRatio;

  const MessageBox({
    super.key,
    this.senderName,
    required this.time,
    required this.message,
    this.alignRight = false,
    this.widthRatio = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: AppGeneralStyle.messageBoxMargin,
          child: Row(
            mainAxisAlignment:
                alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth * widthRatio,
                ),
                child: Container(
                  padding: AppGeneralStyle.messageBoxPadding,
                  decoration: BoxDecoration(
                    color: AppColor.messageBoxBackground,
                    borderRadius: AppGeneralStyle.messageBoxBorderRadius,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: alignRight
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     if (senderName != null && !alignRight)
                            //       Flexible(
                            //         child: Text(
                            //           senderName!,
                            //           style: AppTextStyle.bold16.copyWith(
                            //             color: AppColor.onMessageBoxBackground,
                            //           ),
                            //         ),
                            //       ),
                            //     if (senderName != null && !alignRight)
                            //       const Flexible(
                            //         child: SizedBox(
                            //           width: 4,
                            //         ),
                            //       ),
                            //     Flexible(
                            //       child: Text(
                            //         time,
                            //         style: AppTextStyle.regular12.copyWith(
                            //           color:
                            //               AppColor.onMessageBoxBackgroundLight,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const Flexible(
                            //   child: SizedBox(
                            //     height: 2,
                            //   ),
                            // ),
                            Flexible(
                              child: Text(
                                message,
                                style: AppTextStyle.regular16.copyWith(
                                  color: AppColor.onMessageBoxBackground,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}