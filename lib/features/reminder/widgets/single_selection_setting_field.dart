import 'package:ducktor/common/constants/styles.dart';
import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/features/chatbot/widgets/expandable_widget.dart';
import 'package:ducktor/features/reminder/widgets/option_display.dart';
import 'package:flutter/cupertino.dart';

class SingleSelectionSettingField extends StatelessWidget {
  final int initialItem;
  final void Function(int)? onSelectedItemChanged;
  final void Function()? onTap;
  final bool expand;
  final String title;
  final String display;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int? itemCount;
  const SingleSelectionSettingField({
    super.key,
    this.initialItem = 0,
    this.onSelectedItemChanged,
    required this.expand,
    required this.title,
    required this.display,
    this.onTap,
    required this.itemBuilder,
    this.itemCount,
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
                  pickerTextStyle: AppTextStyle.semiBold18.copyWith(
                    color: DucktorThemeProvider.onBackground,
                  ),
                ),
              ),
              child: CupertinoPicker.builder(
                key: UniqueKey(),
                childCount: itemCount,
                itemExtent: 30,
                scrollController:
                    FixedExtentScrollController(initialItem: initialItem),
                onSelectedItemChanged: onSelectedItemChanged,
                itemBuilder: itemBuilder,
              ),
            ),
          ),
        )
      ],
    );
  }
}
