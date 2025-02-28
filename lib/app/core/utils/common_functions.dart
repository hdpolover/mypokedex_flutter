import 'package:flutter/material.dart';
import 'package:mypokedex/app/core/values/app_colors.dart';

abstract class CommonFunctions {
  static Color getPokemonColor(String color) {
    return AppColors.pokemonColorMap[color] ?? Colors.grey;
  }

  // capitalize the first letter of a string and remove hyphens
  static String capitalize(String s) {
    s = s.replaceAll('-', ' ');
    return s[0].toUpperCase() + s.substring(1);
  }

  // remove new lines and extra spaces
  static String mergeText(String s) {
    return s.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ');
  }

  // convert height from decimeters to centimeters
  static double convertHeightToCm(int height) {
    return height * 10;
  }

  // convert height from decimeters to feet
  static double convertHeightToFt(int height) {
    return height / 3.048;
  }

  // convert weight from hectograms to kilograms
  static double convertWeightToKg(int weight) {
    return weight / 10;
  }

  // convert weight from hectograms to pounds
  static double convertWeight(int weight) {
    return weight / 4.536;
  }

  // show height text in meters
  static String showHeight(int height) {
    String heightText = '';

    double heightInFeet = convertHeightToFt(height);
    // show text feet in format like 1' 6"
    if (heightInFeet > 0) {
      double ft = heightInFeet;
      int feet = ft.floor();
      int inches = ((ft - feet) * 12).round();

      heightText += '$feet\' $inches"';
    }

    String inCm = convertHeightToCm(height).toStringAsFixed(0);

    heightText += ' ($inCm cm)';

    return heightText;
  }

  // show weight text in kilograms
  static String showWeight(int weight) {
    String weightText = '';

    double weightInPounds = convertWeight(weight);
    // show text in pounds
    if (weightInPounds > 0) {
      weightText += '${weightInPounds.toStringAsFixed(1)} lbs';
    }

    String inKg = convertWeightToKg(weight).toStringAsFixed(1);

    weightText += ' ($inKg kg)';

    return weightText;
  }

  // Add this to CommonFunctions class
  static Color getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return Color(0xFFA8A878);
      case 'fire':
        return Color(0xFFF08030);
      case 'water':
        return Color(0xFF6890F0);
      case 'grass':
        return Color(0xFF78C850);
      case 'electric':
        return Color(0xFFF8D030);
      case 'ice':
        return Color(0xFF98D8D8);
      case 'fighting':
        return Color(0xFFC03028);
      case 'poison':
        return Color(0xFFA040A0);
      case 'ground':
        return Color(0xFFE0C068);
      case 'flying':
        return Color(0xFFA890F0);
      case 'psychic':
        return Color(0xFFF85888);
      case 'bug':
        return Color(0xFFA8B820);
      case 'rock':
        return Color(0xFFB8A038);
      case 'ghost':
        return Color(0xFF705898);
      case 'dragon':
        return Color(0xFF7038F8);
      case 'dark':
        return Color(0xFF705848);
      case 'steel':
        return Color(0xFFB8B8D0);
      case 'fairy':
        return Color(0xFFEE99AC);
      default:
        return Colors.grey;
    }
  }
}
