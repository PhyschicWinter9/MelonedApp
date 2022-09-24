// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:newmelonedv2/dailymenu.dart';
import 'login.dart';
import 'register.dart';
import 'analyze.dart';
import 'daily.dart';
import 'menu.dart';
import 'period.dart';
import 'splashscreen.dart';
import 'sub_period/edit_period.dart';
import 'sub_period/historyperiod.dart';
import 'sub_period/new_period.dart';
import 'summary.dart';
import 'style/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'mainmenu': (context) => MainMenu(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/menu': (context) => MainMenu(),
        '/daily': (context) => Daily(),
        '/analyze': (context) => Analyze(),
        '/summary': (context) => Summary(),
        '/period': (context) => Period(),
        '/newperiod': (context) => NewPeriod(),
        '/historyperiod': (context) => HistoryPeriod(),
      },
      theme: MyTheme(),
      home: 
        DailyMenu(),
    );
  }
}