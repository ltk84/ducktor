import 'dart:async';

import 'package:ducktor/features/reminder/model/reminder_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

class ReminderClient {
  static final ReminderClient _instance = ReminderClient._internal();

  ReminderClient._internal();

  factory ReminderClient() {
    return _instance;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  final StreamController<ReceivedNotification>
      didReceiveLocalNotificationStream =
      StreamController<ReceivedNotification>.broadcast();

  /// A notification action which triggers a App navigation event
  static const String navigationActionId = 'id_3';

  static const notificationDetail = NotificationDetails(
    android: AndroidNotificationDetails(
        'daily notification channel id', 'daily notification channel name',
        channelDescription: 'daily notification description',
        sound: RawResourceAndroidNotificationSound('slow_spring_board')),
  );

  Future<void> init() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_duck_face');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  Future<bool> isAndroidPermissionGranted() async {
    final bool granted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;
    return granted;
  }

  Future<bool?> requestPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final bool? granted = await androidImplementation?.requestPermission();
    return granted;
  }

  void configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      // await showDialog(
      //   context: context,
      //   builder: (BuildContext context) => CupertinoAlertDialog(
      //     title: receivedNotification.title != null
      //         ? Text(receivedNotification.title!)
      //         : null,
      //     content: receivedNotification.body != null
      //         ? Text(receivedNotification.body!)
      //         : null,
      //     actions: <Widget>[
      //       CupertinoDialogAction(
      //         isDefaultAction: true,
      //         onPressed: () async {
      //           Navigator.of(context, rootNavigator: true).pop();
      //           await Navigator.of(context).push(
      //             MaterialPageRoute<void>(
      //               builder: (BuildContext context) =>
      //                   SecondPage(receivedNotification.payload),
      //             ),
      //           );
      //         },
      //         child: const Text('Ok'),
      //       )
      //     ],
      //   ),
      // );
    });
  }

  void configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      // await Navigator.of(context).push(MaterialPageRoute<void>(
      //   builder: (BuildContext context) => SecondPage(payload),
      // ));
    });
  }

  Future createReminder(
      {String title = '',
      String body = '',
      required ReminderSetting setting}) async {
    switch (setting.frequency) {
      case Frequency.daily:
        _createReminderDaily(title, body, setting);
        break;
      case Frequency.weekly:
        _createReminderWeekly(title, body, setting);
        break;
      case Frequency.monthly:
        _createReminderMonthly(title, body, setting);
        break;
      case Frequency.yearly:
        _createReminderYearly(title, body, setting);
        break;
    }
  }

  Future _createReminderDaily(
      String title, String body, ReminderSetting setting) async {
    if (setting.freqNum == 1) {
      await flutterLocalNotificationsPlugin.zonedSchedule(0, title, body,
          tz.TZDateTime.from(setting.fromDate, tz.local), notificationDetail,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time);
    } else {
      final timeline = _createDailyTimeline(setting);
      for (var date in timeline) {
        await flutterLocalNotificationsPlugin
            .zonedSchedule(0, title, body, date, notificationDetail,
                androidAllowWhileIdle: true,
                uiLocalNotificationDateInterpretation:
                    UILocalNotificationDateInterpretation.absoluteTime)
            .then((value) => print('done'));
      }
    }
  }

  Future _createReminderWeekly(
      String title, String body, ReminderSetting setting) async {
    if (setting.freqNum == 1) {
      await flutterLocalNotificationsPlugin.zonedSchedule(0, title, body,
          tz.TZDateTime.from(setting.fromDate, tz.local), notificationDetail,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
    } else {
      final timeline = _createWeeklyTimeline(setting);
      for (var date in timeline) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
            0, title, body, date, notificationDetail,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);
      }
    }
  }

  Future _createReminderMonthly(
      String title, String body, ReminderSetting setting) async {
    if (setting.freqNum == 1) {
      await flutterLocalNotificationsPlugin.zonedSchedule(0, title, body,
          tz.TZDateTime.from(setting.fromDate, tz.local), notificationDetail,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime);
    } else {
      final timeline = _createMonthlyTimeline(setting);
      for (var date in timeline) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
            0, title, body, date, notificationDetail,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);
      }
    }
  }

  Future _createReminderYearly(
      String title, String body, ReminderSetting setting) async {
    if (setting.freqNum == 1) {
      await flutterLocalNotificationsPlugin.zonedSchedule(0, title, body,
          tz.TZDateTime.from(setting.fromDate, tz.local), notificationDetail,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dateAndTime);
    } else {
      final timeline = _createYearlyTimeline(setting);
      for (var date in timeline) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
            0, title, body, date, notificationDetail,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);
      }
    }
  }

  List<tz.TZDateTime> _createDailyTimeline(ReminderSetting setting) {
    final timeline = <tz.TZDateTime>[];
    if (setting.toDate != null) {
      final start = setting.fromDate;
      final end = setting.toDate!;
      for (DateTime date = start;
          date.isBefore(end);
          date = date.add(Duration(days: setting.freqNum))) {
        timeline.add(tz.TZDateTime.from(date, tz.local));
      }
    } else {
      int numberOfNoti = setting.times!;
      DateTime startDate = setting.fromDate;
      for (int i = 0; i < numberOfNoti; i++) {
        timeline.add(tz.TZDateTime.from(startDate, tz.local));
        startDate = startDate.add(Duration(days: setting.freqNum));
      }
    }

    return timeline;
  }

  List<tz.TZDateTime> _createWeeklyTimeline(ReminderSetting setting) {
    final timeline = <tz.TZDateTime>[];
    if (setting.toDate != null) {
      final start = setting.fromDate;
      final end = setting.toDate!;
      for (DateTime date = start;
          date.isBefore(end);
          date = date.add(Duration(days: 7 * setting.freqNum))) {
        timeline.add(tz.TZDateTime.from(date, tz.local));
      }
    } else {
      int numberOfNoti = setting.times!;
      DateTime startDate = setting.fromDate;
      for (int i = 0; i < numberOfNoti; i++) {
        timeline.add(tz.TZDateTime.from(startDate, tz.local));
        startDate = startDate.add(Duration(days: 7 * setting.freqNum));
      }
    }

    return timeline;
  }

  List<tz.TZDateTime> _createMonthlyTimeline(ReminderSetting setting) {
    int days = DateUtils.getDaysInMonth(
            setting.fromDate.year, setting.fromDate.month) *
        setting.freqNum;
    final timeline = <tz.TZDateTime>[];
    if (setting.toDate != null) {
      final start = setting.fromDate;
      final end = setting.toDate!;
      for (DateTime date = start;
          date.isBefore(end);
          date = date.add(Duration(days: days))) {
        timeline.add(tz.TZDateTime.from(date, tz.local));
      }
    } else {
      int numberOfNoti = setting.times!;
      DateTime startDate = setting.fromDate;
      for (int i = 0; i < numberOfNoti; i++) {
        timeline.add(tz.TZDateTime.from(startDate, tz.local));
        startDate = startDate.add(Duration(days: days));
      }
    }

    return timeline;
  }

  List<tz.TZDateTime> _createYearlyTimeline(ReminderSetting setting) {
    int days = isLeapYear(setting.fromDate.year) ? 365 : 366;
    final timeline = <tz.TZDateTime>[];
    if (setting.toDate != null) {
      final start = setting.fromDate;
      final end = setting.toDate!;
      for (DateTime date = start;
          date.isBefore(end);
          date = date.add(Duration(days: days))) {
        timeline.add(tz.TZDateTime.from(date, tz.local));
      }
    } else {
      int numberOfNoti = setting.times!;
      DateTime startDate = setting.fromDate;
      for (int i = 0; i < numberOfNoti; i++) {
        timeline.add(tz.TZDateTime.from(startDate, tz.local));
        startDate = startDate.add(Duration(days: days));
      }
    }

    return timeline;
  }
}

bool isLeapYear(int year) =>
    (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
