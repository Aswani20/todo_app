import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/firebase_utils.dart';
import 'package:todoapp/home/tasks/edit_task_screen.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/my_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/provider/auth_provider.dart';

import '../../provider/app_config_provider.dart';

class TaskWidgetItem extends StatefulWidget {
  Task task;
  TaskWidgetItem({super.key, required this.task});

  @override
  State<TaskWidgetItem> createState() => _TaskWidgetItemState();
}

class _TaskWidgetItemState extends State<TaskWidgetItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider =Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(EditTaskScreen.routeName,arguments: widget.task);
      },
      child: Container(
        margin: EdgeInsets.all(12),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {},
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                backgroundColor: MyTheme.redColor,
                foregroundColor: MyTheme.whiteColor,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:provider.appTheme == ThemeMode.light ? MyTheme.whiteColor : MyTheme.blackDark,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color:widget.task.isDone! ? MyTheme.greenColor :  MyTheme.primaryColor,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: 4,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.task.title ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: widget.task.isDone! ? MyTheme.greenColor : MyTheme.primaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.task.description ?? '',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    FirebaseUtils.editIsDone(widget.task, authProvider.currentUser?.id??"");
                    widget.task.isDone = !widget.task.isDone!;
                    setState(() {});
                  },
                  child: widget.task.isDone! ?
                      Text("Done!", style: TextStyle(color: MyTheme.greenColor,fontSize: 22,fontWeight: FontWeight.bold),)
                  :
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyTheme.primaryColor,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 35,
                      color: MyTheme.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
