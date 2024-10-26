import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: ColorsManager.scaffoldBg,
    appBarTheme: AppBarTheme(
      color: ColorsManager.blue,
      titleTextStyle: LightAppStyle.appBar,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Colors.transparent,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      unselectedItemColor: ColorsManager.grey,
      selectedItemColor: ColorsManager.blue,
      selectedIconTheme: IconThemeData(size: 36),
      unselectedIconTheme: IconThemeData(size: 36),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      shape: CircularNotchedRectangle(),
      color: ColorsManager.white
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        iconSize: 28,
        shape: StadiumBorder(
          side: BorderSide(
            color: ColorsManager.white,
            width: 4,
          ),
        )),
  );
  static ThemeData dark = ThemeData();
}