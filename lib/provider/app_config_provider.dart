import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/firebase_utils.dart';
import 'package:todoapp/model/task.dart';

class AppConfigProvider extends ChangeNotifier{
  List<Task> tasksList = [];
  DateTime selectDate = DateTime.now();
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;

  void changeLanguage(String newLanguage){
    if(appLanguage == newLanguage){
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeMode(ThemeMode newMode){
    if(appTheme == newMode){
      return;
    }
    appTheme = newMode;
    notifyListeners();
  }

  void getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<Task> quarySnapshot = await FirebaseUtils.getTaskCollection(uId).get();
    tasksList = quarySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// filtering (select date)
     tasksList = tasksList.where((task){
      if(task.dataTime?.day == selectDate.day &&
          task.dataTime?.month == selectDate.month &&
          task.dataTime?.year == selectDate.year){
              return true;
      }
      return false;
    }).toList();

     /// sorting List
    tasksList.sort(
        (Task task1, Task task2){
           return task1.dataTime!.compareTo(task2.dataTime!);
        }
    );

    notifyListeners();
  }

  void changeSelectedDate(DateTime newDate, String uId){
      selectDate = newDate;
      getAllTasksFromFireStore(uId);
      notifyListeners();
  }
}