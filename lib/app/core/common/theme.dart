import 'package:flutter/material.dart';
import 'package:food_shop/app/core/common/palette.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get basic {
    return ThemeData(
      backgroundColor: Palette.backgroundColor,
      cardColor: Colors.white,
      primarySwatch: Colors.amber,
      appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      canvasColor: Color.fromRGBO(246, 247, 255, 1),
      primaryColor: Palette.primaryColor,
      textTheme: TextTheme(
        bodyText1: GoogleFonts.poppins(),
        bodyText2: GoogleFonts.poppins(),
        subtitle1: GoogleFonts.poppins(color: Palette.greyColor),
        subtitle2: GoogleFonts.poppins(color: Palette.greyColor),
        button: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        headline1: GoogleFonts.poppins(),
        headline2: GoogleFonts.poppins(),
        headline3: GoogleFonts.poppins(),
        headline4: GoogleFonts.poppins(),
        headline5: GoogleFonts.poppins(),
        headline6: GoogleFonts.poppins(),
      ),
      buttonColor: Palette.primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color.fromRGBO(244, 246, 253, 1),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      accentColor: Colors.white,
      accentIconTheme: IconThemeData(color: Colors.black),
      dividerColor: Colors.black12,
      fixTextFieldOutlineLabel: true,
      textTheme: TextTheme(
        bodyText1: GoogleFonts.poppins(),
        bodyText2: GoogleFonts.poppins(),
        subtitle1: GoogleFonts.poppins(color: Palette.greyColor),
        subtitle2: GoogleFonts.poppins(color: Palette.greyColor),
        button: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        headline1: GoogleFonts.poppins(),
        headline2: GoogleFonts.poppins(),
        headline3: GoogleFonts.poppins(),
        headline4: GoogleFonts.poppins(),
        headline5: GoogleFonts.poppins(),
        headline6: GoogleFonts.poppins(),
      ),
      buttonColor: Palette.primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color.fromRGBO(244, 246, 253, 1),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
