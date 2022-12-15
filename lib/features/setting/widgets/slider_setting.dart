import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/common/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SliderSetting extends StatefulWidget {
  final String label;
  final double initialValue;
  final double min;
  final double max;
  final Function(double)? onChange;
  const SliderSetting(
      {super.key,
      required this.initialValue,
      required this.label,
      this.onChange,
      this.min = 0,
      this.max = 1});

  @override
  State<SliderSetting> createState() => _SliderSettingState();
}

class _SliderSettingState extends State<SliderSetting> {
  late double _value;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 4, 22, 0),
            child: Row(
              children: [
                Text('${widget.label}: ', style: AppTextStyle.semiBold16),
                Text(_value.toStringAsFixed(1), style: AppTextStyle.regular16),
              ],
            ),
          ),
          SfSlider(
            activeColor: DucktorThemeProvider.primaryDark,
            inactiveColor: DucktorThemeProvider.primary.withOpacity(0.64),
            showLabels: true,
            value: _value,
            stepSize: 0.1,
            min: widget.min,
            max: widget.max,
            onChanged: (newValue) {
              setState(() {
                _value = newValue;
              });

              if (widget.onChange != null) {
                widget.onChange!(newValue);
              }
            },
          ),
        ],
      ),
    );
  }
}
