import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/common/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderTile extends StatelessWidget {
  final String title;
  final String message;
  final DateTime dateTime;
  final IconData iconData;
  final Function()? onTap;

  const ReminderTile({
    super.key,
    this.iconData = Icons.notifications_rounded,
    this.onTap,
    required this.title,
    required this.message,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DucktorThemeProvider.reminderTileBackground,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 8, 18, 12),
          child: Row(children: [
            Icon(iconData),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.isEmpty ? '(empty title)' : title,
                    style: AppTextStyle.semiBold16,
                  ),
                  Text(
                    message.isEmpty ? '(empty message)' : message,
                    style: AppTextStyle.regular12,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('HH:mm').format(dateTime),
                  style: AppTextStyle.semiBold16,
                ),
                Text(
                  DateFormat('dd-MM-yyyy').format(dateTime),
                  style: AppTextStyle.regular12,
                ),
              ],
            )),
          ]),
        ),
      ),
    );
  }
}
