// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_vh/providers/countries.dart';
import 'package:test_task_vh/providers/currentData.dart';
import 'package:test_task_vh/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Countries(),
        ),
        ChangeNotifierProxyProvider<Countries, CurrentData>(
          create: (context) => CurrentData(),
          update: (context, countries, currentData) => CurrentData(
            countries.countries[0].code,
            countries.countries[0].flagUrl,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Test Task',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff8EAAFB),
          textTheme: TextTheme(
            headline1: TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
            bodyText1: TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            bodyText2: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xff594C74),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        home: LoginScreen(),
      ),
    );
  }
}
