import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/my_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../provider/app_config_provider.dart';

class TaskWidgetItem extends StatelessWidget {
  const TaskWidgetItem({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
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
                color: MyTheme.primaryColor,
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
                        'Task Title',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: MyTheme.primaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
