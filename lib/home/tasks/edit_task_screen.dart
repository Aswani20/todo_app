import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/dialog_utils.dart';
import 'package:todoapp/firebase_utils.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/my_theme.dart';
import 'package:todoapp/provider/app_config_provider.dart';
import 'package:todoapp/provider/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = "editTask";

  EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  DateTime selectedDate = DateTime.now();

  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  late AppConfigProvider provider;
  Task? task;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPersistentFrameCallback((_) {
    //   task = ModalRoute.of(context)!.settings.arguments as Task;
    // selectedDate = task!.dataTime!;
    // titleController.text = task!.title ?? "";
    // descriptionController.text = task!.description ?? ""; });
    // Future.delayed(
    //     Duration(microseconds: 400),
    //   () {
    //   task = ModalRoute.of(context)!.settings.arguments as Task;
    //   selectedDate = task!.dataTime!;
    //   titleController.text = task!.title ?? "";
    //   descriptionController.text = task!.description ?? "";
    // });
  }

  @override
  Widget build(BuildContext context) {
    if(task == null){
      task = ModalRoute.of(context)!.settings.arguments as Task;
      selectedDate = task!.dataTime!;
      titleController.text = task!.title ?? "";
      descriptionController.text =task!.description ?? "";
    }

    provider = Provider.of<AppConfigProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: screenSize.height * 0.1,
                color: MyTheme.primaryColor,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: screenSize.height * 0.04),
                  height: screenSize.height * 0.7,
                  width: screenSize.width * .8,
                  decoration: BoxDecoration(
                    color: provider.appTheme == ThemeMode.light
                        ? MyTheme.whiteColor
                        : MyTheme.backgroundDark,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        'Edit Task',
                        // AppLocalizations.of(context)!.add_new_task,
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
                                // onChanged: (text) {
                                //   title = text;
                                // },
                                controller: titleController,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Please Enter task';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: provider.appTheme ==
                                                  ThemeMode.light
                                              ? MyTheme.blackColor
                                              : MyTheme.whiteColor)),
                                  hintText:
                                      AppLocalizations.of(context)!.enter_task,
                                  hintStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                // onChanged: (text) {
                                //   description = text;
                                // },
                                controller: descriptionController,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return "Please Enter Description";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: provider.appTheme ==
                                                  ThemeMode.light
                                              ? MyTheme.blackColor
                                              : MyTheme.whiteColor)),
                                  hintText: AppLocalizations.of(context)!
                                      .enter_discription,
                                  hintStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                ),
                                maxLines: 4,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)!.select_time,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showCalendar();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  DateFormat.yMd().format(selectedDate),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  editTask();
                                },
                                child: Text(AppLocalizations.of(context)!.add))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );

    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }

  void editTask() {
    if (formKey.currentState?.validate() == true) {
      task!.title=titleController.text;
      task!.description=descriptionController.text;
      task!.dataTime = selectedDate;
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      DialogUtils.showLoading(context, 'Waiting...');
      FirebaseUtils.editTask(task!, authProvider.currentUser?.id ?? "")
          .then((value) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, 'Task Edit Successfully',
            posActionName: "Ok", posAction: () {
          Navigator.pop(context);
        });
      }).timeout(Duration(milliseconds: 500), onTimeout: () {
        Fluttertoast.showToast(
            msg: "Task Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        print("Task edit successfully");
        provider.getAllTasksFromFireStore(authProvider.currentUser?.id ?? "");
        Navigator.pop(context);
      });
    }
  }
}
