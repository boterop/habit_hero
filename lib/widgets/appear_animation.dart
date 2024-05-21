import 'package:flutter/material.dart';

class AppearAnimation extends StatefulWidget {
  final Widget child;
  const AppearAnimation({super.key, required this.child});

  @override
  State<AppearAnimation> createState() => _AppearAnimationState();
}

class _AppearAnimationState extends State<AppearAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutBack,
  );

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
