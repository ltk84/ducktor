import 'dart:math';

import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/common/constants/styles.dart';
import 'package:flutter/material.dart';

class ThemeTile extends StatelessWidget {
  final String label;
  final bool check;
  final Function()? onTap;
  final Color primary;
  final Color background;
  final Color onPrimary;

  const ThemeTile({
    super.key,
    required this.label,
    this.check = false,
    this.onTap,
    this.primary = Colors.white,
    this.background = Colors.white,
    this.onPrimary = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DucktorThemeProvider.settingTileBackground,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: [
                primary,
                background,
                Colors.white,
              ],
              stops: const [0.36, 0.72, 1.0],
              transform: const GradientRotation(pi / 4),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
          child: Row(children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.semiBold16.copyWith(
                  color: onPrimary,
                ),
              ),
            ),
            if (check) const Icon(Icons.check_rounded, color: Colors.green),
          ]),
        ),
      ),
    );
  }
}
