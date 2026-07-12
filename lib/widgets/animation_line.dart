import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedLine extends StatefulWidget {
  const AnimatedLine({super.key});

  @override
  State<AnimatedLine> createState() => _AnimatedLineState();
}

class _AnimatedLineState extends State<AnimatedLine>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) => ClipRect(
        child: Align(
          alignment: Alignment.centerLeft,
          widthFactor: controller.value,
          child: child,
        ),
      ),
      child: SvgPicture.asset(
        'assets/logo/Rectangle 9.svg',
        width: 100,
        height: 20,
      ),
    );
  }
}