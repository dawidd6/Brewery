import 'package:flutter/material.dart';

class InfiniteScaleAnimation extends StatefulWidget {
  final Widget child;
  final Duration interval;
  final Duration duration;

  InfiniteScaleAnimation({this.child, this.duration, this.interval});

  @override
  State<StatefulWidget> createState() => InfiniteScaleAnimationState();
}

class InfiniteScaleAnimationState extends State<InfiniteScaleAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.3)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50.0),
      TweenSequenceItem(
          tween: Tween(begin: 1.3, end: 1.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50.0),
    ]).animate(controller);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(widget.interval, () {
          controller.reset();
          controller.forward();
        });
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: widget.child,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: child,
        );
      },
    );
  }
}
