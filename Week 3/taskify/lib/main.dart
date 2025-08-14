import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/constants/colors.dart';
import 'package:taskify/screens/home_page.dart';
import 'package:taskify/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTheme(); 
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;

    // splash Screeen delay (2 seconds)
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      _isLoading = false;
    });
  }

  void toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskify',
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
      themeMode: _themeMode,
      home: _isLoading
          ? SplashScreen()
          : HomePage(
              isDarkMode: _themeMode == ThemeMode.dark,
              onThemeToggle: toggleTheme,
            ),
    );
  }
}
