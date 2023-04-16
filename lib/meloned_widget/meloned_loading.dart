import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmelonedv2/style/colortheme.dart';

class MelonedLoading extends StatelessWidget {
  const MelonedLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: ColorCustom.browncolor(),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'กำลังโหลดข้อมูล',
          style: GoogleFonts.kanit(
            fontSize: 20,
            color: ColorCustom.browncolor(),
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ));
  }
}
