import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: tdBGColor,
        primaryColor: tdBlue,
        appBarTheme: AppBarTheme(
          backgroundColor: tdBGColor,
          iconTheme: IconThemeData(color: tdBlack),
          elevation: 0,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: tdBlack),
          bodyMedium: TextStyle(color: tdGrey),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: tdBlue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.grey[400]),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
