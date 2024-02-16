import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = [];
  strengths.addAll([.01, .02, .03, .04, .05, .06, .07, .08, 0.9]);
  strengths.addAll([.1, .2, .3, .4, .5, .6, .7, .8, .9, 1]);
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}
