import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class SignBtn extends StatelessWidget {
  final ControllerCallback callback;
  final String title;
  final Color color;
  SignBtn({
    required this.callback,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 300,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color,
          ),
          onPressed: callback,
          child: Text(
            title,
            style: GoogleFonts.kanit(),
          ),
        ),
      ),
    );
  }
}
