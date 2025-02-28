import 'package:flutter/material.dart';
import 'package:mypokedex/app/core/values/app_text_styles.dart';

class PokeTypeChip extends StatelessWidget {
  final String type;

  const PokeTypeChip({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type,
        style: AppTextStyles.bodySmall.copyWith(
          color: Colors.white,
          fontSize: 8,
        ),
      ),
    );
  }
}
