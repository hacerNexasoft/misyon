// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// Uygulama içerisindeki Text'leri responsive boyutlandırmalara uyumlu hale getirmek için kodlanan sınıf

class ScaleFactorText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDirection? textDirection;
  final bool? softWrap;
  const ScaleFactorText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.textDirection,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    double textScaleFactor;
    if (MediaQuery.of(context).textScaleFactor > 1.0) {
      var difference = MediaQuery.of(context).textScaleFactor - 1.0;
      textScaleFactor = 1.0 + (difference / 4);
    } else {
      textScaleFactor = MediaQuery.of(context).textScaleFactor;
    }
    return Text(
      text ?? '',
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      textDirection: textDirection,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
    );
  }
}