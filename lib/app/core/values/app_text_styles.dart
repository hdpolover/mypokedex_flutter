import 'package:flutter/material.dart';

abstract class AppTextStyles {
  // title large
  static const TextStyle titleLarge = TextStyle(
    color: Colors.black,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  // title medium
  static const TextStyle titleMedium = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  // small body text
  static const TextStyle bodySmall = TextStyle(
    color: Colors.black,
    fontSize: 12.0,
  );

  // medium body text
  static const TextStyle bodyMedium = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
  );
}
