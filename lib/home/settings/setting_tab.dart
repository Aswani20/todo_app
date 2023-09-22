import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/home/settings/language_bottom_sheet.dart';
import 'package:todoapp/home/settings/theme_bottom_sheet.dart';
import 'package:todoapp/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../provider/app_config_provider.dart';
class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.language, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14,),),
          const SizedBox(height: 15,),
          InkWell(
            onTap: (){
              showLanguageBottomSheet();
            },
            child: Container(
              margin:const EdgeInsets.symmetric(horizontal: 10),
              padding:const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: provider.appTheme == ThemeMode.light ? MyTheme.whiteColor : MyTheme.blackDark,
                border: Border.all(width: 2,style: BorderStyle.solid,color: MyTheme.primaryColor)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.appLanguage == 'en' ? AppLocalizations.of(context)!.english:AppLocalizations.of(context)!.arabic,style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14,fontWeight: FontWeight.normal,color: MyTheme.primaryColor),),
                  Icon(Icons.arrow_drop_down, color: MyTheme.primaryColor,),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30,),
          Text(AppLocalizations.of(context)!.mode, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14,),),
          const SizedBox(height: 15,),
          InkWell(
            onTap: (){
              showThemeBottomSheet();
            },
            child: Container(
              margin:const EdgeInsets.symmetric(horizontal: 10),
              padding:const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: provider.appTheme == ThemeMode.light ? MyTheme.whiteColor : MyTheme.blackDark,
                  border: Border.all(width: 2,style: BorderStyle.solid,color: MyTheme.primaryColor)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.appTheme == ThemeMode.light ? AppLocalizations.of(context)!.light:AppLocalizations.of(context)!.dark ,style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14,fontWeight: FontWeight.normal,color: MyTheme.primaryColor),),
                  Icon(Icons.arrow_drop_down, color: MyTheme.primaryColor,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showBottomSheet(context: context, builder: (context)=> LanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showBottomSheet(context: context, builder: (context)=>ThemeBottomSheet());
  }


}
