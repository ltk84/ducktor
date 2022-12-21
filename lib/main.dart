import 'dart:async';

import 'package:ducktor/features/reminder/remider_client.dart';
import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/features/chatbot/chat_screen.dart';
import 'package:ducktor/features/reminder/widgets/reminder_setting_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

Future main() async {
  await dotenv.load(fileName: '.env');

  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();

  await ReminderClient().init();

  await DucktorThemeProvider.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatScreen(),
    );
  }
}

// TODO: Example for using ReminderClient
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: ((context) => const ReminderSettingDialog()),
                );

                // await remiderClient.createReminder(
                //     title: 'test',
                //     body: 'test',
                //     setting: ReminderSetting(
                //         frequency: Frequency.daily,
                //         fromDate: DateTime.now().add(Duration(seconds: 1)),
                //         freqNum: 1,
                //         toDate: DateTime.now().add(Duration(days: 20))));
              },
              child: const Text('Show notification'))
        ],
      ),
    );
  }
}
