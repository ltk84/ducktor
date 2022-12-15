import 'package:flutter/material.dart';

import '../../../common/utilities/theme_provider.dart';
import '../../../common/constants/styles.dart';

class TextInfoWidget extends StatelessWidget {
  final Color primaryColor;
  final String text;
  final String description;
  final bool isMain;
  const TextInfoWidget({
    super.key,
    required this.text,
    required this.description,
    this.primaryColor = Colors.blue,
    this.isMain = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: isMain
                ? AppTextStyle.bold24.copyWith(
                    color: primaryColor,
                  )
                : AppTextStyle.semiBold18.copyWith(
                    color: primaryColor,
                  ),
          ),
          const TextSpan(
            text: '\n',
          ),
          TextSpan(
            text: description,
            style: AppTextStyle.regular12.copyWith(
              color: DucktorThemeProvider.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
