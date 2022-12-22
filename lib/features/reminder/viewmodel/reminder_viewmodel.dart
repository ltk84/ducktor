import 'package:ducktor/features/reminder/model/reminder_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderViewModel {
  Future<List<ReminderInfo>> getReminderInfo() async {
    return SharedPreferences.getInstance().then(
      (prefs) {
        List<ReminderInfo> reminderInfo = prefs
                .getStringList('reminders')
                ?.map((e) => ReminderInfo.fromJson(e))
                .toList() ??
            <ReminderInfo>[];

        reminderInfo.removeWhere(
            (element) => element.dateTime.isBefore(DateTime.now()));
        reminderInfo.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        prefs.setStringList(
            'reminders', reminderInfo.map((e) => e.toJson()).toList());
        return reminderInfo;
      },
    );
  }
}
