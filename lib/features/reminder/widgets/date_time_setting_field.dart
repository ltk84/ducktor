import 'package:ducktor/common/constants/styles.dart';
import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/features/chatbot/widgets/expandable_widget.dart';
import 'package:ducktor/features/reminder/widgets/option_display.dart';
import 'package:flutter/cupertino.dart';

class DateTimeSettingField extends StatelessWidget {
  final void Function(DateTime) onDateTimeChanged;
  final void Function()? onTap;
  final String title;
  final String display;
  final bool expand;
  final bool selected;
  final CupertinoDatePickerMode mode;
  final bool use24hFormat;
  final DateTime? initialDateTime;
  final DateTime? minimumDate;

  const DateTimeSettingField({
    super.key,
    required this.onDateTimeChanged,
    this.onTap,
    required this.title,
    required this.display,
    required this.expand,
    this.selected = false,
    this.mode = CupertinoDatePickerMode.dateAndTime,
    this.use24hFormat = false,
    this.initialDateTime,
    this.minimumDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: OptionDisplay(
            name: title,
            display: display,
            selected: selected,
          ),
        ),
        ExpandableWidget(
          expand: expand,
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              color: DucktorThemeProvider.background,
              border: Border(
                bottom: BorderSide(
                  color: DucktorThemeProvider.background.withOpacity(0.12),
                  width: 0.5,
                ),
              ),
            ),
            child: CupertinoTheme(
              data: CupertinoThemeData(
                brightness: Brightness.dark,
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: AppTextStyle.semiBold18.copyWith(
                    color: DucktorThemeProvider.onBackground,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                key: UniqueKey(),
                mode: mode,
                initialDateTime: initialDateTime,
                use24hFormat: use24hFormat,
                onDateTimeChanged: onDateTimeChanged,
                minimumDate: minimumDate,
              ),
            ),
          ),
        )
      ],
    );
  }
}
