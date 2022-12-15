import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/common/constants/styles.dart';
import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Function()? onTap;

  const SettingTile({
    super.key,
    required this.label,
    this.iconData = Icons.settings,
    this.onTap,
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
          margin: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Row(children: [
            Icon(iconData),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.regular16,
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ]),
        ),
      ),
    );
  }
}
