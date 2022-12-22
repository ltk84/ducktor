import 'package:ducktor/common/constants/styles.dart';
import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/features/reminder/model/reminder_setting.dart';
import 'package:ducktor/features/reminder/widgets/content_setting_field.dart';
import 'package:ducktor/features/reminder/widgets/date_time_setting_field.dart';
import 'package:ducktor/features/reminder/widgets/single_selection_setting_field.dart';
import 'package:ducktor/features/reminder/widgets/single_text_setting_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../reminder_client.dart';

class ReminderSettingDialog extends StatefulWidget {
  const ReminderSettingDialog({super.key});

  @override
  State<ReminderSettingDialog> createState() => _ReminderSettingDialogState();
}

class _ReminderSettingDialogState extends State<ReminderSettingDialog> {
  late int _selectedFrequencyIndex;
  late int _freqNum;
  late DateTime _time;
  late DateTime? _endDate;
  late int? _repeatTime;
  late String _title;
  late String _message;

  late int _expandIndex;
  late int _endOption;

  @override
  void initState() {
    _expandIndex = 5;
    _selectedFrequencyIndex = 0;
    _freqNum = 1;
    _time = DateTime.now();
    _endDate = null;
    _repeatTime = 1;
    _endOption = 1;
    _title = '';
    _message = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: DucktorThemeProvider.primary,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 14, bottom: 14),
                child: Text(
                  'Reminder Settings',
                  style: AppTextStyle.semiBold16.copyWith(
                    color: DucktorThemeProvider.onPrimary,
                  ),
                ),
              ),
              ContentSettingField(
                expand: _expandIndex == 5,
                display: _title,
                onTap: () {
                  setState(() {
                    if (_expandIndex == 5) {
                      _expandIndex = -1;
                    } else {
                      _expandIndex = 5;
                    }
                  });
                },
                onTitleChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                onMessageChanged: (value) {
                  setState(() {
                    _message = value;
                  });
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    SingleSelectionSettingField(
                      expand: _expandIndex == 0,
                      title: 'Frequency',
                      display: Frequency.values[_selectedFrequencyIndex].name,
                      onTap: () {
                        setState(() {
                          if (_expandIndex == 0) {
                            _expandIndex = -1;
                          } else {
                            _expandIndex = 0;
                          }
                        });
                      },
                      initialItem: _selectedFrequencyIndex,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedFrequencyIndex = index;
                          final untilDate = _calculateUntilDate();
                          if (_endDate == null ||
                              _endDate!.isBefore(untilDate)) {
                            _endDate = untilDate;
                          }
                        });
                      },
                      itemCount: Frequency.values.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Text(
                            Frequency.values[index].name,
                          ),
                        );
                      },
                    ),
                    SingleSelectionSettingField(
                      expand: _expandIndex == 1,
                      title: 'Every',
                      display:
                          '$_freqNum ${getFreqUnit(_selectedFrequencyIndex)}${(_freqNum == 1) ? '' : 's'}',
                      onTap: () {
                        setState(() {
                          if (_expandIndex == 1) {
                            _expandIndex = -1;
                          } else {
                            _expandIndex = 1;
                          }
                        });
                      },
                      initialItem: _freqNum - 1,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _freqNum = index + 1;
                          final untilDate = _calculateUntilDate();
                          if (_endDate == null ||
                              _endDate!.isBefore(untilDate)) {
                            _endDate = untilDate;
                          }
                        });
                      },
                      itemBuilder: (context, index) {
                        if (index >= 0) {
                          String display =
                              '${index + 1} ${getFreqUnit(_selectedFrequencyIndex)}${(index == 0) ? '' : 's'}';

                          return Center(
                            child: Text(
                              display,
                            ),
                          );
                        }
                      },
                    ),
                    DateTimeSettingField(
                      title: 'Time',
                      display: DateFormat('HH:mm').format(_time),
                      expand: _expandIndex == 2,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      initialDateTime: _time,
                      onTap: () {
                        setState(() {
                          if (_expandIndex == 2) {
                            _expandIndex = -1;
                          } else {
                            _expandIndex = 2;
                          }
                        });
                      },
                      onDateTimeChanged: (val) {
                        setState(() {
                          _time = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                color: DucktorThemeProvider.background,
                margin: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    DateTimeSettingField(
                      title: 'Until',
                      display: _endDate == null || _endOption != 0
                          ? ''
                          : DateFormat('dd/MM/yyyy').format(_endDate!),
                      expand: _expandIndex == 3,
                      selected: _endOption == 0,
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: _endDate ??
                          _calculateUntilDate().add(const Duration(seconds: 1)),
                      minimumDate: DateUtils.dateOnly(_calculateUntilDate()),
                      onTap: () {
                        setState(() {
                          if (_expandIndex == 3) {
                            _expandIndex = -1;
                          } else {
                            _expandIndex = 3;

                            _endOption = 0;
                            _repeatTime = null;
                            _endDate ??= _calculateUntilDate();
                          }
                        });
                      },
                      onDateTimeChanged: (val) {
                        setState(() {
                          if (val.isBefore(
                              DateUtils.dateOnly(_calculateUntilDate()))) {
                            return;
                          }
                          _endDate = val;
                        });
                      },
                    ),
                    SingleTextSettingField(
                      title: 'For',
                      display: _repeatTime == null
                          ? ''
                          : '${_repeatTime!} time${(_repeatTime! == 1 ? '' : 's')}',
                      selected: _endOption == 1,
                      onTap: () {
                        setState(() {
                          if (_expandIndex == 4) {
                            _expandIndex = -1;
                          } else {
                            _expandIndex = 4;

                            _endOption = 1;
                            _endDate = null;
                            _repeatTime = 1;
                          }
                        });
                      },
                      expand: _expandIndex == 4,
                      inputLabel:
                          'time${_repeatTime == null || _repeatTime == 1 ? '' : 's'}',
                      initialValue: _repeatTime == null ? null : '$_repeatTime',
                      onChanged: (value) {
                        var result = int.tryParse(value);
                        if (result != null && result > 0) {
                          setState(() {
                            if (value.isNotEmpty) {
                              _repeatTime = int.parse(value);
                            } else {
                              _repeatTime = null;
                            }
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: AppButtonStyle.text(
                        foregroundColor: DucktorThemeProvider.onPrimary,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      style: AppButtonStyle.elevated(
                        foregroundColor: DucktorThemeProvider.onPrimary,
                        backgroundColor: Colors.green,
                        radius: 8,
                        overlayColor: const Color.fromARGB(36, 227, 227, 227),
                      ),
                      onPressed: () {
                        final result = {
                          'title': _title,
                          'message': _message,
                          'setting': ReminderSetting(
                            frequency:
                                Frequency.values[_selectedFrequencyIndex],
                            freqNum: _freqNum,
                            fromDate: _time.isBefore(DateTime.now())
                                ? _calculateUntilDate()
                                : _time,
                            toDate: _endDate,
                            times: _repeatTime,
                          ),
                        };
                        Navigator.of(context).pop(result);
                      },
                      child: const Text('Confirm'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _calculateUntilDate() {
    switch (Frequency.values[_selectedFrequencyIndex]) {
      case Frequency.daily:
        final date = _time.add(Duration(days: _freqNum));
        return date;
      case Frequency.weekly:
        return _time.add(Duration(days: 7 * _freqNum));
      case Frequency.monthly:
        int days = DateUtils.getDaysInMonth(_time.year, _time.month) * _freqNum;
        return _time.add(Duration(days: days));
      case Frequency.yearly:
        int days = isLeapYear(_time.year) ? 365 : 366;
        return _time.add(Duration(days: days));
    }
  }

  String getFreqUnit(int freqIndex) {
    switch (freqIndex) {
      case 0:
        return 'day';
      case 1:
        return 'week';
      case 2:
        return 'month';
      case 3:
        return 'year';
      default:
        return '';
    }
  }
}
