import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class AppTheme {
  static ThemeData light = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsManager.blue,
        primary: ColorsManager.blue,
        onPrimary: ColorsManager.white,
      ),
      scaffoldBackgroundColor: ColorsManager.lightScaffoldBg,
      appBarTheme: AppBarTheme(
        elevation: 0,
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
          shape: CircularNotchedRectangle(), color: ColorsManager.white),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorsManager.blue,
          iconSize: 28,
          shape: StadiumBorder(
            side: BorderSide(
              color: ColorsManager.white,
              width: 4,
            ),
          )),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorsManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
      ));
  static ThemeData dark = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsManager.blue,
        primary: ColorsManager.darkScaffoldBg,
        onPrimary: ColorsManager.darkGrey,
      ),
      scaffoldBackgroundColor: ColorsManager.darkScaffoldBg,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: ColorsManager.blue,
        titleTextStyle: DarkAppStyle.appBar,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.transparent,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        unselectedItemColor: ColorsManager.white,
        selectedItemColor: ColorsManager.blue,
        selectedIconTheme: IconThemeData(size: 36),
        unselectedIconTheme: IconThemeData(size: 36),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
          shape: CircularNotchedRectangle(), color: ColorsManager.darkGrey),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorsManager.blue,
          iconSize: 28,
          shape: StadiumBorder(
            side: BorderSide(
              color: ColorsManager.darkGrey,
              width: 4,
            ),
          )),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorsManager.darkGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
      ));
}
