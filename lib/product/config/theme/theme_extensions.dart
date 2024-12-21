import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get tiny => _createFontWeight(this, FontWeight.w200);
  TextStyle get regular => _createFontWeight(this, FontWeight.w400);
  TextStyle get medium => _createFontWeight(this, FontWeight.w500);
  TextStyle get semibold => _createFontWeight(this, FontWeight.w600);
  TextStyle get bold => _createFontWeight(this, FontWeight.w700);
}

TextStyle _createFontWeight(TextStyle textStyle, FontWeight fontWeight) {
  return GoogleFonts.publicSans(
    textStyle: textStyle,
    fontWeight: fontWeight,
  );
}