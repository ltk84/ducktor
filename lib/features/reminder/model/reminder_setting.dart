enum Frequency { daily, weekly, monthly, yearly }

class ReminderSetting {
  final Frequency frequency;
  final int freqNum;
  final DateTime fromDate;
  final DateTime? toDate;
  final int? times;

  ReminderSetting(
      {required this.frequency,
      this.freqNum = 1,
      required this.fromDate,
      this.toDate,
      this.times});
}
