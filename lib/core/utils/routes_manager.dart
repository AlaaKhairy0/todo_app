import 'package:flutter/material.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/presentation/screens/auth/login/login.dart';
import 'package:todo_app/presentation/screens/auth/register/register.dart';
import 'package:todo_app/presentation/screens/home/edit_task/edit_task.dart';
import 'package:todo_app/presentation/screens/home/home_screen.dart';

class RoutesManager {
  static const String home = '/home';
  static const String editTask = '/editTask';
  static const String register = '/register';
  static const String login = '/login';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      // case editTaskRoute :
      //   return MaterialPageRoute(builder: (context) => EditTask(),);
      case register:
        return MaterialPageRoute(
          builder: (context) => const Register(),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
    }
  }
}