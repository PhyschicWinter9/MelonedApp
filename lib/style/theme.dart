import 'package:flutter/material.dart';
import 'colortheme.dart';

ThemeData MyTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorCustom.mediumgreencolor(),
    colorScheme: ColorScheme.light(
      primary: ColorCustom.mediumgreencolor(),
      secondary: ColorCustom.lightyellowcolor(),
    ),
    appBarTheme: AppBarTheme(
      toolbarHeight: 70,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontFamily: 'Kanit',
          fontSize: 20,
      ),
      iconTheme: IconThemeData(
        color: ColorCustom.lightyellowcolor(),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: ColorCustom.darkgreencolor()
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: ColorCustom.darkgreencolor(),
            style: BorderStyle.solid,
          ),
        ),
        hintStyle: TextStyle(
          color: ColorCustom.mediumgreencolor(),
        ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: ColorCustom.lightyellowcolor(),
      unselectedLabelColor: ColorCustom.lightgreencolor(),
      labelStyle: TextStyle(
        fontFamily: 'Kanit',
        fontSize: 16,
      ),
      unselectedLabelStyle: 
      TextStyle(
        fontFamily: 'Kanit',
        fontSize: 16,
      ),
      indicator: BoxDecoration(
        color: ColorCustom.darkgreencolor(),
      ),
    ),
  );
}
