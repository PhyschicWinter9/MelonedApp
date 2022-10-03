// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:newmelonedv2/dailymenu.dart';
import 'package:newmelonedv2/sub_daily/fert.dart';
import 'package:newmelonedv2/sub_summary/sum_weekly.dart';
import 'package:newmelonedv2/sub_daily/note.dart';
import 'login.dart';
import 'register.dart';
import 'analyze.dart';
import 'daily.dart';
import 'menu.dart';
import 'period.dart';
import 'splashscreen.dart';
import 'sub_analyze/addanalyze.dart';
import 'sub_analyze/afteranalyze.dart';
import 'sub_analyze/analyzedetail.dart';
import 'sub_analyze/editanalyze.dart';
import 'sub_daily/humid.dart';
import 'sub_daily/sub_fert/addfert.dart';
import 'sub_daily/sub_fert/editfert.dart';
import 'sub_daily/sub_note/addnote.dart';
import 'sub_daily/sub_note/editnote.dart';
import 'sub_period/detail_period.dart';
import 'sub_period/historyperiod.dart';
import 'sub_period/new_period.dart';
import 'sub_summary/sum_daily.dart';
import 'sub_summary/sum_monthly.dart';
import 'sub_summary/sum_period.dart';
import 'sub_summary/sum_yearly.dart';
import 'summary.dart';
import 'style/theme.dart';
import 'sub_daily/sub_fert/fertdropdown.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

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
        // '/editfert': (context) => EditFert(),*
        '/addnote': (context) => AddNote(),
        // '/editnote': (context) => EditNote(),*
        '/humid':(context) => Humid(),
        '/analyzedetail':(context) => AnalyzeDetail(),
        '/addanalyze':(context) => AddAnalyze(),
        '/afteranalyze':(context) => AfterAnalyze(),
        '/editanalyze':(context) => EditAnalyze(),
        '/dailysummaryform':(context) => SummaryDaily(),
        '/weeklysummaryform':(context) => SummaryWeekly(),
        '/monthlysummaryform':(context) => SummaryMonthly(),
        '/yearlysummaryform':(context) => SummaryYearly(),
        '/periodsummaryform':(context) => SummaryPeriod(),


        //* This is the page that will be edited and send data to the database
      },
      theme: MyTheme(),
      home: MainMenu(),
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],

      //Debug Mode Route and Comment the initialRoute
      // home: Daily(),
    );
  }
}
