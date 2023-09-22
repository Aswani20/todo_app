import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/my_theme.dart';

import '../../provider/app_config_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.appTheme == ThemeMode.light ? MyTheme.whiteColor:MyTheme.blackDark,
      padding: const EdgeInsets.all(40),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
                provider.changeMode(ThemeMode.light);
            },
            child: provider.appTheme == ThemeMode.light ?
            getSelectedItemWidget(AppLocalizations.of(context)!.light):
                getUnSelectedItemWidget(AppLocalizations.of(context)!.light)
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
              onTap: () {
                provider.changeMode(ThemeMode.dark);
              },
              child: provider.appTheme == ThemeMode.dark ?
              getSelectedItemWidget(AppLocalizations.of(context)!.dark):
              getUnSelectedItemWidget(AppLocalizations.of(context)!.dark)
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.normal,
              color: MyTheme.primaryColor),
        ),
        Icon(Icons.check, color: MyTheme.primaryColor)
      ],
    );
  }
  Widget getUnSelectedItemWidget(String text){
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(fontWeight: FontWeight.normal),
    );
  }
}
