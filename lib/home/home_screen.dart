import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/auth/login/login_screen.dart';
import 'package:todoapp/home/settings/setting_tab.dart';
import 'package:todoapp/home/tasks/show_add_task_bottom_sheet.dart';
import 'package:todoapp/home/tasks/task_list_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/my_theme.dart';
import 'package:todoapp/provider/auth_provider.dart';
import '../provider/app_config_provider.dart';

//AppLocalizations.of(context)!.app_title

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text( selectedIndex == 0 ? "ToDo List " "${authProvider.currentUser!.name}": "Settings "
          "${authProvider.currentUser!.name}",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: provider.appTheme == ThemeMode.light
            ? MyTheme.whiteColor
            : MyTheme.blackDark,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: AppLocalizations.of(context)!.task_list),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: AppLocalizations.of(context)!.setting),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  List<Widget> tabs = [
    TaskListTab(),
    SettingsTab(),
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ShowAddTaskBottomSheet(),
    );
  }
}
