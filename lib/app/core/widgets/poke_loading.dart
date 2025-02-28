import 'package:flutter/material.dart';
import 'package:mypokedex/app/core/values/app_text_styles.dart';

class PokeLoading extends StatefulWidget {
  final bool isWithText;
  final bool isSmall;
  final bool isWhite;

  const PokeLoading({
    super.key,
    this.isWithText = true,
    this.isSmall = false,
    this.isWhite = false,
  });

  @override
  State<PokeLoading> createState() => _PokeLoadingState();
}

class _PokeLoadingState extends State<PokeLoading>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Setup rotation animation
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Setup scaling animation
    _scaleController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // Make scale animation go back and forth
    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scaleController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _scaleController.forward();
      }
    });

    // Start scale animation
    _scaleController.forward();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return SizedBox(
                width: widget.isSmall ? 30 : 50,
                height: widget.isSmall ? 30 : 50,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: RotationTransition(
                    turns: _rotationController,
                    child: Image.asset(
                      'assets/pokeball.png',
                      color: widget.isWhite ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          widget.isWithText
              ? Text(
                  'Now loading...',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: widget.isWhite ? Colors.white : Colors.grey[800],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
