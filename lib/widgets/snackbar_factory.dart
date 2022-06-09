import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnackBarFactory {
  SnackBar getSnackBar({String? title, bool? isFail, double? fontSize}) {
    return SnackBar(
      backgroundColor: isFail == true ? Color(0xFFEC3939) : Color(0xFF4CD964),
      margin: EdgeInsets.all(12),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title??"",
            style: GoogleFonts.metrophobic(
              fontSize: getSnackBarFontSize(fontSize??0.2),
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  double getSnackBarFontSize(double fontSize) {
    double textSize = 0;
    if (fontSize >= 1.3) {
      textSize = 12;
    } else {
      textSize = 17;
    }
    return textSize;
  }
}
