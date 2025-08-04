import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(
        'opacity',
        0.0.tweenTo(
            1.0), // Supercharged package is used for shorthand Tween creation
        duration: 500.milliseconds,
      )
      ..tween(
        'translateY',
        (-30.0).tweenTo(0.0),
        duration: 500.milliseconds,
        curve: Curves.easeOut,
      );

    return PlayAnimationBuilder<Movie>(
      tween: tween,
      duration: tween.duration,
      delay: (500 * delay).round().milliseconds,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.get('opacity'),
          child: Transform.translate(
            offset: Offset(0, value.get('translateY')),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
