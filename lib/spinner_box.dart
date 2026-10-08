import 'package:flutter/material.dart';

class SpinnerBox extends StatefulWidget {
  const SpinnerBox({super.key});

  @override
  State<SpinnerBox> createState() => _SpinnerBoxState();
}

class _SpinnerBoxState extends State<SpinnerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
