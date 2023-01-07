import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memory/home_page.dart';

void main() {
  runApp(const MemoryApp());
}

class MemoryApp extends StatelessWidget {
  const MemoryApp({super.key});

  static const _defaultColor = Color(0xff57CDFF);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Memory',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: _defaultColor,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 24),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _defaultColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xffD9D9D9),
            textStyle: const TextStyle(fontSize: 24, color: Colors.black),
            fixedSize: const Size(100, 100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
