import 'package:flutter/material.dart';

/// import shimmer
import 'package:shimmer/shimmer.dart';

class CustomPokeCardShimmer extends StatelessWidget {
  const CustomPokeCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: Colors.white,
      ),
    );
  }
}
