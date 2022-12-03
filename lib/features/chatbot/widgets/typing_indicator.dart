import 'dart:math';

import 'package:flutter/material.dart';

import '../../../common/constants/assets.dart';
import '../../../common/constants/colors.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _repeatingController;
  final List<Interval> _dotIntervals = const [
    Interval(0.25, 0.8),
    Interval(0.35, 0.9),
    Interval(0.45, 1.0),
  ];

  final bubbleColor = AppColor.typingDot;
  final flashingCircleDarkColor = AppColor.flashingCircleDark;
  final flashingCircleBrightColor = AppColor.flashingCircleBright;

  @override
  void initState() {
    _repeatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _repeatingController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _repeatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xfffbd200),
                backgroundImage: AssetImage(AppAsset.duckFace),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              decoration: BoxDecoration(
                color: AppColor.messageBoxBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlashingCircle(
                    index: 0,
                    repeatingController: _repeatingController,
                    dotIntervals: _dotIntervals,
                    flashingCircleDarkColor: flashingCircleDarkColor,
                    flashingCircleBrightColor: flashingCircleBrightColor,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  FlashingCircle(
                    index: 1,
                    repeatingController: _repeatingController,
                    dotIntervals: _dotIntervals,
                    flashingCircleDarkColor: flashingCircleDarkColor,
                    flashingCircleBrightColor: flashingCircleBrightColor,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  FlashingCircle(
                    index: 2,
                    repeatingController: _repeatingController,
                    dotIntervals: _dotIntervals,
                    flashingCircleDarkColor: flashingCircleDarkColor,
                    flashingCircleBrightColor: flashingCircleBrightColor,
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

class FlashingCircle extends StatelessWidget {
  const FlashingCircle({
    super.key,
    required this.index,
    required this.repeatingController,
    required this.dotIntervals,
    required this.flashingCircleBrightColor,
    required this.flashingCircleDarkColor,
  });

  final int index;
  final AnimationController repeatingController;
  final List<Interval> dotIntervals;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: repeatingController,
      builder: (context, child) {
        final circleFlashPercent = dotIntervals[index].transform(
          repeatingController.value,
        );
        final circleColorPercent = sin(pi * circleFlashPercent);

        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(
              flashingCircleDarkColor,
              flashingCircleBrightColor,
              circleColorPercent,
            ),
          ),
        );
      },
    );
  }
}
