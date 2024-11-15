import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../providers/language_provider.dart';
import '../../../../../providers/theme_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of(context);
    LanguageProvider languageProvider = Provider.of(context);
    String selectedLanguage =
        languageProvider.isEnglish() ? 'English' : 'العربية';
    String selectedMode = themeProvider.isLightMode()
        ? AppLocalizations.of(context)!.light
        : AppLocalizations.of(context)!.dark;
    return Container(
      padding: REdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: themeProvider.isLightMode()
                ? LightAppStyle.settingsTabLabel
                : DarkAppStyle.settingsTabLabel,
          ),
          SizedBox(
            height: 10.h,
          ),
          buildSettingsTabComponent(context,
              item: MenuItem(item1: 'English', item2: 'العربية'),
              selectedItem: selectedLanguage, onSelected: (newLang) {
            languageProvider.changeAppLang(newLang!);
            setState(() {
              selectedLanguage = newLang ?? selectedLanguage;
            });
          }),
          SizedBox(
            height: 16.h,
          ),
          Text(
            AppLocalizations.of(context)!.mode,
            style: themeProvider.isLightMode()
                ? LightAppStyle.settingsTabLabel
                : DarkAppStyle.settingsTabLabel,
          ),
          SizedBox(
            height: 10.h,
          ),
          buildSettingsTabComponent(context,
              item: MenuItem(
                  item1: AppLocalizations.of(context)!.light,
                  item2: AppLocalizations.of(context)!.dark),
              selectedItem: selectedMode, onSelected: (newMode) {
            themeProvider.changeThemeMode(context, newMode!);
            setState(() {
              selectedMode = newMode ?? selectedMode;
            });
          }),
        ],
      ),
    );
  }

  Widget buildSettingsTabComponent(context,
      {required MenuItem item,
      required String selectedItem,
      required Function(String?) onSelected}) {
    ThemeProvider themeProvider = Provider.of(context);

    return Container(
      padding: REdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border.all(
          color: ColorsManager.blue,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedItem,
            style: themeProvider.isLightMode()
                ? LightAppStyle.settingsTabSelectedItem
                : DarkAppStyle.settingsTabSelectedItem,
          ),
          buildDropDown(
              item: item, selectedItem: selectedItem, onSelected: onSelected),
        ],
      ),
    );
  }

  Widget buildDropDown(
          {required MenuItem item,
          required String selectedItem,
          required Function(String?) onSelected}) =>
      DropdownButton<String>(
        underline: const SizedBox(),
        iconSize: 28,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: ColorsManager.blue,
        ),
        isDense: true,
        items: <String>[item.item1, item.item2].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onSelected,
      );
}

class MenuItem {
  String item1;
  String item2;

  MenuItem({required this.item1, required this.item2});
}
