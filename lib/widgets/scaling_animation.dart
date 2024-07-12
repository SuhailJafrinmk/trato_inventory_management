// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class OneTimeScalingAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;

  const OneTimeScalingAnimation({
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.minScale = 0.1,
    this.maxScale = .8,
  });

  @override
  _OneTimeScalingAnimationState createState() => _OneTimeScalingAnimationState();
}

class _OneTimeScalingAnimationState extends State<OneTimeScalingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: widget.minScale, end: widget.maxScale)
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}
