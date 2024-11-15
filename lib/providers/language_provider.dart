import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLang = 'en';

  void changeAppLang(String newLang) {
    if (newLang == 'English') {
      if (currentLang == 'en') return;
      currentLang = 'en';
    } else {
      if (currentLang == 'ar') return;
      currentLang = 'ar';
    }
    saveLang(newLang);
    notifyListeners();
  }

  bool isEnglish() {
    return currentLang == 'en';
  }

  Future<void> saveLang(String recentLang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (recentLang == 'English') {
      await prefs.setString('lang', 'en');
    } else {
      await prefs.setString('lang', 'ar');
    }
  }

  Future<void> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentLang = prefs.getString('lang') ?? 'en';
    notifyListeners();
  }
}
