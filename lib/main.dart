import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/providers/language_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider()..getTheme(),
      ),
      ChangeNotifierProvider(
        create: (context) => LanguageProvider()..getLang(),
      )
    ],
    child: const MyApp(),
  ));
}
