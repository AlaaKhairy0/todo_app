import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  void changeThemeMode(context, String newTheme) {
    if (newTheme == AppLocalizations.of(context)!.light) {
      if (currentTheme == ThemeMode.light) return;
      currentTheme = ThemeMode.light;
    } else {
      if (currentTheme == ThemeMode.dark) return;
      currentTheme = ThemeMode.dark;
    }
    saveTheme(context, newTheme);
    notifyListeners();
  }

  bool isLightMode() {
    return currentTheme == ThemeMode.light;
  }

  Future<void> saveTheme(context, String recentTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (recentTheme == AppLocalizations.of(context)!.light) {
      await prefs.setString('theme', 'Light');
    } else {
      await prefs.setString('theme', 'Dark');
    }
  }

  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String recentTheme = prefs.getString('theme') ?? 'Light';
    if (recentTheme == 'Light') {
      currentTheme = ThemeMode.light;
    } else {
      currentTheme = ThemeMode.dark;
    }
    notifyListeners();
  }
}
