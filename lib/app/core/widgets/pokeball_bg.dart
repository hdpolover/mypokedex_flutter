import 'package:flutter/material.dart';

class PokeballBg extends StatelessWidget {
  final double height;
  final double width;
  final bool isFront;

  const PokeballBg({
    super.key,
    this.isFront = false,
    this.height = 200,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/pokeball.png",
      height: height,
      width: width,
      // Set the color of the pokeball to a bit transparent white
      opacity: AlwaysStoppedAnimation(isFront ? 0.6 : 0.4),
      color: isFront ? Colors.grey : Colors.white,
    );
  }
}
