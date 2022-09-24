// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:newmelonedv2/dailymenu.dart';
import 'package:newmelonedv2/test.dart';
import 'login.dart';
import 'register.dart';
import 'analyze.dart';
import 'daily.dart';
import 'menu.dart';
import 'period.dart';
import 'splashscreen.dart';
import 'sub_daily/sub_fert/addfert.dart';
import 'sub_daily/sub_fert/editfert.dart';
import 'sub_daily/sub_note/addnote.dart';
import 'sub_daily/sub_note/editnote.dart';
import 'sub_period/edit_period.dart';
import 'sub_period/historyperiod.dart';
import 'sub_period/new_period.dart';
import 'summary.dart';
import 'style/theme.dart';
import 'sub_daily/sub_fert/fertdropdown.dart';

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
      initialRoute: '/splashscreen',
      routes: {
        'mainmenu': (context) => MainMenu(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/splashscreen': (context) => SplashScreen(),
        '/menu': (context) => MainMenu(),
        '/daily': (context) => Daily(),
        '/analyze': (context) => Analyze(),
        '/summary': (context) => Summary(),
        '/period': (context) => Period(),
        '/newperiod': (context) => NewPeriod(),
        '/historyperiod': (context) => HistoryPeriod(),
        '/addfert': (context) => AddFert(),
        '/editfert': (context) => EditFert(),
        '/addnote': (context) => AddNote(),
        '/editnote': (context) => EditNote(),
      },
      theme: MyTheme(),
      home: 
        MainMenu(),
    );
  }
}