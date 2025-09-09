import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/providers/theme_provider.dart';
import 'package:taskify/providers/todo_provider.dart';
import 'package:taskify/screens/home_page.dart';
import 'package:taskify/screens/splash_screen.dart';
import 'package:taskify/constants/colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskify',
      themeMode: themeProvider.themeMode,
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
      home: _showSplash ? const SplashScreen() : HomePage(),
    );
  }
}
