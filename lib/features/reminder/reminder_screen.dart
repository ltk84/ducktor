import 'package:ducktor/common/constants/styles.dart';
import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/features/reminder/model/reminder_info.dart';
import 'package:ducktor/features/reminder/viewmodel/reminder_viewmodel.dart';
import 'package:ducktor/features/reminder/widgets/reminder_tile.dart';
import 'package:flutter/material.dart';

class ReminderScreen extends StatelessWidget {
  ReminderScreen({super.key});

  final viewModel = ReminderViewModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: DucktorThemeProvider.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Reminders",
            style: AppTextStyle.semiBold18.copyWith(
              color: DucktorThemeProvider.onBackground,
            ),
          ),
          centerTitle: true,
          leading: BackButton(
            color: DucktorThemeProvider.onBackground,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: FutureBuilder(
              future: viewModel.getReminderInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<ReminderInfo> reminderInfo = snapshot.data ?? [];

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: reminderInfo.length,
                    itemBuilder: ((context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ReminderTile(
                            title: reminderInfo[index].title,
                            message: reminderInfo[index].message,
                            dateTime: reminderInfo[index].dateTime,
                          ),
                        )),
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: DucktorThemeProvider.primary,
                  ));
                }
              }),
        ),
      ),
    );
  }
}
