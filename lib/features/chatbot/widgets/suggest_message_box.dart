import 'package:flutter/material.dart';

import '../../../common/utilities/theme_provider.dart';
import '../../../common/constants/styles.dart';

class SuggestMessageBox extends StatelessWidget {
  final String message;
  final EdgeInsets margin;
  final Function()? onPressed;
  const SuggestMessageBox({
    super.key,
    required this.message,
    this.margin = const EdgeInsets.fromLTRB(4, 4, 4, 4),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: AppButtonStyle.suggesstMessage(
          backgroundColor: DucktorThemeProvider.suggestMessageBoxBackground,
          foregroundColor: DucktorThemeProvider.onSuggestMessageBoxBackground,
          overlayColor: DucktorThemeProvider.suggestMessageBoxOverlay,
          outlineColor: DucktorThemeProvider.suggestMessageBoxOutline,
        ),
        child: Text(
          message,
        ),
      ),
    );
  }
}
