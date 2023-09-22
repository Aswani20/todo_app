import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/my_theme.dart';

import '../../provider/app_config_provider.dart';

class ShowAddTaskBottomSheet extends StatefulWidget {
  const ShowAddTaskBottomSheet({super.key});

  @override
  State<ShowAddTaskBottomSheet> createState() => _ShowAddTaskBottomSheetState();
}

class _ShowAddTaskBottomSheetState extends State<ShowAddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.appTheme == ThemeMode.light ? MyTheme.whiteColor : MyTheme.backgroundDark,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.add_new_task,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (text){
                      if(text == null || text.isEmpty){
                        return 'Please Enter task';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: provider.appTheme == ThemeMode.light ? MyTheme.blackColor:MyTheme.whiteColor)
                      ),
                      hintText: AppLocalizations.of(context)!.enter_task ,
                      hintStyle: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (text){
                      if(text == null || text.isEmpty){
                        return "Please Enter Description";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: provider.appTheme == ThemeMode.light ? MyTheme.blackColor:MyTheme.whiteColor)
                      ),
                      hintText: AppLocalizations.of(context)!.enter_discription,
                      hintStyle: Theme.of(context).textTheme.titleSmall,
                    ),
                    maxLines: 4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppLocalizations.of(context)!.select_time,style: Theme.of(context).textTheme.titleSmall,),
                ),
                InkWell(
                  onTap: (){
                    showCalendar();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(DateFormat.yMd().format(selectedDate), textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleSmall,),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  addTask();
                }, child: Text(AppLocalizations.of(context)!.add))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365),),);

    if(chosenDate != null){
      selectedDate = chosenDate;
    }
    setState(() {

    });
  }

  void addTask() {
    if(formKey.currentState?.validate() == true){

    }
  }
}
