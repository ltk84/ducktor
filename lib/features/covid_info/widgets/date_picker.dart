import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/styles.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.background,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () async {
          await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime.now());
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                color: AppColor.onBackground,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                '11/11/2022',
                style: AppTextStyle.regular18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
