import 'package:flutter/material.dart';

abstract class AppColors {
  static const colorPrimary = Colors.blue;
  static const colorPrimarySwatch = Colors.blue;

  // Define a map for color conversion
  static Map<String, Color> pokemonColorMap = {
    "green": Colors.green.shade400,
    "red": Colors.red.shade400,
    "blue": Colors.blue.shade400,
    "black": Colors.black,
    "brown": Colors.brown.shade400,
    "gray": Colors.grey.shade400,
    "pink": Colors.pink.shade400,
    "purple": Colors.purple.shade400,
    "white": Colors.grey,
    "yellow": Colors.orange,
  };
}
