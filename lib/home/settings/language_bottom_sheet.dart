import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/my_theme.dart';

import '../../provider/app_config_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.appTheme == ThemeMode.light ? MyTheme.whiteColor:MyTheme.blackDark,
      padding: EdgeInsets.all(40),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              provider.changeLanguage('en');
            },
            child: provider.appLanguage == 'en' ?
            getSelectedItemWidget(AppLocalizations.of(context)!.english):
            getUnSelectedItemWidget(AppLocalizations.of(context)!.english),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              provider.changeLanguage('ar');
            },
            child:provider.appLanguage == 'ar' ?
              getSelectedItemWidget(AppLocalizations.of(context)!.arabic):
              getUnSelectedItemWidget(AppLocalizations.of(context)!.arabic),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme
              .of(context)
              .textTheme
              .titleSmall!
              .copyWith(
              fontWeight: FontWeight.normal,
              color: MyTheme.primaryColor),
        ),
        Icon(
          Icons.check,
          color: MyTheme.primaryColor,
        )
      ],
    );
  }
  
  Widget getUnSelectedItemWidget(String text){
    return Text(
      text,
      style: Theme
          .of(context)
          .textTheme
          .titleSmall!
          .copyWith(fontWeight: FontWeight.normal),
    );
  }
}
