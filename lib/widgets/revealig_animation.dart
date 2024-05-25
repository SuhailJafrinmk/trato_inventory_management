import 'package:flutter/material.dart';

class LeftToRightRevealAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const LeftToRightRevealAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  _LeftToRightRevealAnimationState createState() => _LeftToRightRevealAnimationState();
}

class _LeftToRightRevealAnimationState extends State<LeftToRightRevealAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
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
        return ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: _animation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
