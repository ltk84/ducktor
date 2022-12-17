import 'package:ducktor/common/constants/styles.dart';
import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/features/chatbot/widgets/expandable_widget.dart';
import 'package:ducktor/features/reminder/widgets/option_display.dart';
import 'package:flutter/material.dart';

class ContentSettingField extends StatelessWidget {
  final void Function()? onTap;
  final void Function(String)? onTitleChanged;
  final void Function(String)? onMessageChanged;
  final bool expand;
  final String display;

  const ContentSettingField({
    super.key,
    this.onTap,
    required this.expand,
    this.onTitleChanged,
    this.onMessageChanged,
    this.display = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: OptionDisplay(
            name: 'Content',
            display: display,
          ),
        ),
        ExpandableWidget(
          expand: expand,
          child: Container(
            decoration: BoxDecoration(
              color: DucktorThemeProvider.background,
              border: Border(
                bottom: BorderSide(
                  color: DucktorThemeProvider.onBackground.withOpacity(0.12),
                  width: 0.5,
                ),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
              child: Column(
                children: [
                  _buildTextField(
                      title: 'Title', onChanged: onTitleChanged, maxLength: 30),
                  const SizedBox(height: 10.0),
                  _buildTextField(
                      title: 'Message',
                      onChanged: onMessageChanged,
                      maxLength: 100),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
      {required String title, Function(String)? onChanged, int? maxLength}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70,
          height: 32,
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: AppTextStyle.semiBold16.copyWith(
              color: DucktorThemeProvider.onBackground.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            onChanged: onChanged,
            style: AppTextStyle.regular16.copyWith(
              color: DucktorThemeProvider.onBackground.withOpacity(0.7),
            ),
            maxLines: null,
            keyboardAppearance: Brightness.dark,
            keyboardType: TextInputType.multiline,
            maxLength: maxLength,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: DucktorThemeProvider.onBackground.withOpacity(0.24),
                  width: 0.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: DucktorThemeProvider.onBackground.withOpacity(0.24),
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
