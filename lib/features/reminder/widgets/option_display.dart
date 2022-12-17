import 'package:ducktor/common/constants/styles.dart';
import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:flutter/material.dart';

class OptionDisplay extends StatelessWidget {
  final String name;
  final String display;
  final bool selected;
  const OptionDisplay({
    super.key,
    required this.name,
    required this.display,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
      decoration: BoxDecoration(
        color: DucktorThemeProvider.background,
        border: Border(
          bottom: BorderSide(
            color: DucktorThemeProvider.onBackground.withOpacity(0.12),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: AppTextStyle.semiBold16.copyWith(
              color: DucktorThemeProvider.onBackground,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Flexible(
            child: Text(
              display,
              style: AppTextStyle.semiBold16.copyWith(
                color: DucktorThemeProvider.onBackground.withOpacity(0.38),
              ),
            ),
          ),
          if (selected)
            const SizedBox(
              width: 12,
            ),
          if (selected)
            const Icon(Icons.check, color: Colors.green, size: 20.0),
        ],
      ),
    );
  }
}
