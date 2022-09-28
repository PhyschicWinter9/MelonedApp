import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colortheme.dart';

class TextCustom {
  static TextStyle logofont1() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w500,
      color: ColorCustom.orangecolor(),
    )
  );
  static TextStyle logofont2() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w500,
      color: ColorCustom.lightgreencolor(),
    )
  );
  static TextStyle heading2() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: ColorCustom.mediumgreencolor(),
    ),
  );
  static TextStyle textboxlabel() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: ColorCustom.browncolor(),
    ),
  );
  static TextStyle textboxhint() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 18,
      color: ColorCustom.lightgreencolor()
    ),
  );
  static TextStyle tiletext() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 14,
      color: ColorCustom.browncolor(),
    ),
  );
  static TextStyle tiletext2() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 14,
      color: ColorCustom.browncolor(),
      fontWeight: FontWeight.bold,
    ),
  );

  static TextStyle normal_mdg20() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 20,
      color: ColorCustom.mediumgreencolor(),
    ),
  );

  static TextStyle normal_dg16() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 16,
      color: ColorCustom.darkgreencolor(),
    ),
  );

  static TextStyle normal_dg18() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 18,
      color: ColorCustom.darkgreencolor(),
    ),
  );

    static TextStyle normal_lg16() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 16,
      color: ColorCustom.lightgreencolor(),
    ),
  );

  static TextStyle normal_mdg16() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 16,
      color: ColorCustom.mediumgreencolor(),
    ),
  );

  static TextStyle normal_b16() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 16,
      color: ColorCustom.browncolor(),
    ),
  );

  static TextStyle bold_b20() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 20,
      color: ColorCustom.browncolor(),
      fontWeight: FontWeight.bold,
    ),
  );

  static TextStyle bold_b16() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 16,
      color: ColorCustom.browncolor(),
      fontWeight: FontWeight.bold,
    ),
  );

  static TextStyle semibold_dg20() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 20,
      color: ColorCustom.darkgreencolor(),
      fontWeight: FontWeight.w500,
    ),
  );
  

  static TextStyle buttontext() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );

  static TextStyle buttontext2() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ColorCustom.darkgreencolor(),
    ),
  );
   static TextStyle buttontext3() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  static TextStyle previewtext() => GoogleFonts.kanit(
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.grey[300],
    ),
  );
  
}