import 'dart:math';
import 'package:flutter/material.dart';

LinearGradient getRandomGradient({int alpha = 125}) {
  final random = Random();

  Color getRandomColor() {
    return Color.fromARGB(
      alpha,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  return LinearGradient(
    colors: [getRandomColor(), getRandomColor()],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
