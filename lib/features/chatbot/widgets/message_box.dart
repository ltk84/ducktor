import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/utilities/theme_provider.dart';
import '../../../common/constants/styles.dart';
import '../../../common/constants/assets.dart';
import '../widgets/expandable_widget.dart';

class MessageBox extends StatefulWidget {
  final String time;
  final String message;
  final bool alignRight;
  final double widthRatio;
  final bool highlight;
  final bool showButton;
  final Function()? buttonHandler;
  final String buttonContent;

  const MessageBox({
    super.key,
    required this.time,
    required this.message,
    this.alignRight = false,
    this.widthRatio = 0.6,
    this.highlight = false,
    this.showButton = false,
    this.buttonHandler,
    this.buttonContent = 'Tap here',
  });

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  bool showTime = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: widget.alignRight
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!widget.alignRight)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: DucktorThemeProvider.ducktorBackground,
                  backgroundImage: const AssetImage(AppAsset.duckFace),
                ),
              ),
            if (!widget.alignRight)
              const SizedBox(
                width: 8,
              ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * widget.widthRatio,
              ),
              child: Column(
                crossAxisAlignment: widget.alignRight
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showTime = !showTime;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                      decoration: BoxDecoration(
                        color: widget.highlight
                            ? DucktorThemeProvider.primaryMessageBoxBackground
                            : DucktorThemeProvider.messageBoxBackground,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(!widget.alignRight ? 8 : 18),
                          topRight: Radius.circular(widget.alignRight ? 8 : 18),
                          bottomLeft: const Radius.circular(18),
                          bottomRight: const Radius.circular(18),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: widget.alignRight
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.message,
                                    style: AppTextStyle.regular16.copyWith(
                                      color: widget.highlight
                                          ? DucktorThemeProvider
                                              .onPrimaryMessageBoxBackground
                                          : DucktorThemeProvider
                                              .onMessageBoxBackground,
                                    ),
                                  ),
                                ),
                                if (widget.showButton)
                                  Container(
                                    padding: const EdgeInsets.only(top: 4),
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: widget.buttonHandler,
                                      style: AppButtonStyle.elevated(
                                        backgroundColor: DucktorThemeProvider
                                            .buttonOnMessageBoxBackground,
                                        foregroundColor: DucktorThemeProvider
                                            .onButtonOnMessageBoxBackground,
                                      ),
                                      child: Text(widget.buttonContent),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ExpandableWidget(
                    expand: showTime,
                    child: Row(
                      mainAxisAlignment: widget.alignRight
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                          child: Text(
                            DateFormat('kk:mm, dd-MM-yyyy').format(
                              DateTime.parse(widget.time),
                            ),
                            style: AppTextStyle.regular12.copyWith(
                              color: DucktorThemeProvider.onBackgroundLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
