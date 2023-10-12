import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/auth/login/login_screen.dart';
import 'package:todoapp/auth/register/register_screen.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/home/tasks/edit_task_screen.dart';
import 'package:todoapp/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/provider/app_config_provider.dart';
import 'package:todoapp/provider/auth_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  //     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>AppConfigProvider()),
    ChangeNotifierProvider(create: (context)=> AuthProvider()),
  ], child: MyApp(),));
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context)=>AppConfigProvider(),
  //     child: MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      themeMode: provider.appTheme,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        RegisterScreen.routeName : (context) => RegisterScreen(),
        LoginScreen.routeName : (context) => LoginScreen(),
        EditTaskScreen.routeName: (context) =>EditTaskScreen(),
      },
    );
  }
}
