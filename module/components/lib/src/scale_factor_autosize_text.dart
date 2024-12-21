// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ScaleFactorAutoSizeText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final double? minFontSize;
  final double? maxFontSize;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final Widget? overflowReplacement;
  const ScaleFactorAutoSizeText({
    super.key,
    required this.text,
    this.style,
    this.minFontSize,
    this.maxFontSize,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflowReplacement,
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
    return AutoSizeText(
      text ?? '',
      style: style,
      minFontSize: minFontSize ?? 12,
      maxFontSize: maxFontSize ?? double.infinity,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflowReplacement: overflowReplacement,
      textScaleFactor: textScaleFactor,
    );
  }
}