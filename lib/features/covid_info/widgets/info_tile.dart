import 'package:flutter/material.dart';

import '../../../common/constants/styles.dart';

class InfoTile extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final String content;
  final Color foregroundColor;
  const InfoTile({
    super.key,
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
    this.icon = Icons.person,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(icon, color: foregroundColor),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  content,
                  style: AppTextStyle.regular16.copyWith(
                    color: foregroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
