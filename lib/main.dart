import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/provider/app_config_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context)=>AppConfigProvider(),
      child: MyApp(),
    ),
  );
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
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
