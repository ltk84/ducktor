import 'package:ducktor/common/constants/styles.dart';
import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/features/chatbot/widgets/expandable_widget.dart';
import 'package:ducktor/features/reminder/widgets/option_display.dart';
import 'package:flutter/material.dart';

class SingleTextSettingField extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String display;
  final bool selected;
  final bool expand;
  final String inputLabel;
  final String? initialValue;
  final void Function(String)? onChanged;
  const SingleTextSettingField({
    super.key,
    this.onTap,
    required this.title,
    required this.display,
    this.selected = false,
    required this.expand,
    required this.inputLabel,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child:
              OptionDisplay(name: title, display: display, selected: selected),
        ),
        ExpandableWidget(
          expand: expand,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: DucktorThemeProvider.background,
                border: Border(
                    bottom: BorderSide(
                  color: DucktorThemeProvider.onBackground.withOpacity(0.12),
                  width: 0.5,
                ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80.0,
                  child: TextFormField(
                    initialValue: initialValue,
                    onChanged: onChanged,
                    style: AppTextStyle.semiBold16.copyWith(
                      color: DucktorThemeProvider.onBackground.withOpacity(0.7),
                    ),
                    keyboardAppearance: Brightness.dark,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: true),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: DucktorThemeProvider.onBackground
                                .withOpacity(0.24),
                            width: 0.5,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: DucktorThemeProvider.onBackground
                                .withOpacity(0.24),
                            width: 0.5,
                          )),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  inputLabel,
                  style: AppTextStyle.semiBold16.copyWith(
                    color: DucktorThemeProvider.onBackground.withOpacity(0.7),
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
