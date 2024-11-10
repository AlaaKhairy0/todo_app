import 'package:flutter/material.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/presentation/screens/home/edit_task/edit_task.dart';
import 'package:todo_app/presentation/screens/home/home_screen.dart';

class RoutesManager {
  static const String homeRoute = '/home';
  static const String editTaskRoute = '/editTask';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      // case editTaskRoute :
      //   return MaterialPageRoute(builder: (context) => EditTask(),);
    }
  }
}