import 'dart:convert';

class ReminderInfo {
  final String title;
  final String message;
  final DateTime dateTime;

  ReminderInfo({
    required this.title,
    required this.message,
    required this.dateTime,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'message': message,
      'dateTime': dateTime.toString(),
    };
  }

  factory ReminderInfo.fromMap(Map<String, dynamic> map) {
    return ReminderInfo(
      title: map['title'],
      message: map['message'],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReminderInfo.fromJson(String source) =>
      ReminderInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
