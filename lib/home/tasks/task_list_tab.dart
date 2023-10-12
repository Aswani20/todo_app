import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/firebase_utils.dart';
import 'package:todoapp/home/tasks/task_widget.dart';
import 'package:todoapp/my_theme.dart';
import 'package:todoapp/provider/auth_provider.dart';

import '../../model/task.dart';
import '../../provider/app_config_provider.dart';


class TaskListTab extends StatefulWidget {

  TaskListTab({super.key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    provider.getAllTasksFromFireStore(authProvider.currentUser?.id??"");

    return Column(
      children: [
        CalendarTimeline(
          initialDate: provider.selectDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date){
            provider.changeSelectedDate(date,authProvider.currentUser?.id??"");
          },
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
            itemBuilder: (context,index) {
              return TaskWidgetItem(task: provider.tasksList[index],);
            } ,
            itemCount: provider.tasksList.length,
          ),
        ),
      ],
    );
  }


}
