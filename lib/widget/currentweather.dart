import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
// import 'package:geolocator/geolocator.dart';

Widget currentWeather(IconData icon, String temp, String location) {
  return Container(
    padding: EdgeInsets.all(25),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.orange,
              size: 50,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '$temp°',
              style: GoogleFonts.kanit(fontSize: 50, color: Colors.black),
            ),
          ],
        ),
        Text(
          '$location',
          style: GoogleFonts.kanit(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
