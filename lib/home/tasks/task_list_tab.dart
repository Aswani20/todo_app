import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/home/tasks/task_widget.dart';
import 'package:todoapp/my_theme.dart';

import '../../provider/app_config_provider.dart';


class TaskListTab extends StatelessWidget {
  const TaskListTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: provider.appTheme == ThemeMode.light ? MyTheme.blackColor : MyTheme.whiteColor,
          dayColor:provider.appTheme == ThemeMode.light ?  MyTheme.blackColor : MyTheme.whiteColor,
          activeDayColor: Colors.white,
          activeBackgroundDayColor:provider.appTheme == ThemeMode.light ?MyTheme.primaryColor:MyTheme.blackColor,
          dotsColor: MyTheme.whiteColor,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context,index) => TaskWidgetItem(),
            itemCount: 30,
          ),
        ),
      ],
    );
  }
}
