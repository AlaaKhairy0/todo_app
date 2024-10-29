import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String selectedLanguage = 'English';
  String selectedMode = 'Light';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Language',
            style: LightAppStyle.settingsTabLabel,
          ),
          const SizedBox(
            height: 10,
          ),
          buildSettingsTabComponent(
              item: MenuItem(item1: 'English', item2: 'العربية'),
              selectedItem: selectedLanguage,
              onSelected: (newLang) {
                setState(() {
                  selectedLanguage = newLang ?? selectedLanguage;
                });
              }),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Mode',
            style: LightAppStyle.settingsTabLabel,
          ),
          const SizedBox(
            height: 10,
          ),
          buildSettingsTabComponent(
              item: MenuItem(item1: 'Light', item2: 'Dark'),
              selectedItem: selectedMode,
              onSelected: (newMode) {
                setState(() {
                  selectedMode = newMode ?? selectedMode;
                });
              }),
        ],
      ),
    );
  }

  Widget buildSettingsTabComponent(
          {required MenuItem item,
          required String selectedItem,
          required Function(String?) onSelected}) =>
      Container(
        padding: const EdgeInsets.all(10),
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
              style: LightAppStyle.settingsTabSelectedItem,
            ),
            buildDropDown(
                item: item, selectedItem: selectedItem, onSelected: onSelected),
          ],
        ),
      );

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
