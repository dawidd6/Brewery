import 'dart:math';

import 'package:flutter/material.dart';

class RotateAnimation extends StatefulWidget {
  final Widget child;
  final Duration interval;
  final Duration duration;
  final bool loop;

  RotateAnimation(
      {Key key, this.child, this.duration, this.interval, this.loop})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RotateAnimationState();
}

class RotateAnimationState extends State<RotateAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 360.0 * pi / 180.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 100.0),
    ]).animate(controller);
    if (widget.loop) {
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(widget.interval, () {
            try {
              controller.reset();
              controller.forward();
            } catch (_) {
              return;
            }
          });
        }
      });
    }
    controller.forward();
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
      child: widget.child,
      builder: (context, child) {
        return Transform.rotate(
          angle: animation.value,
          child: child,
        );
      },
    );
  }
}
