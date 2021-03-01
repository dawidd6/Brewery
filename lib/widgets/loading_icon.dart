import 'dart:math';

import 'package:flutter/material.dart';

class LoadingIcon extends StatefulWidget {
  LoadingIcon({Key key}) : super(key: key);

  @override
  _LoadingIconState createState() => _LoadingIconState();
}

class _LoadingIconState extends State<LoadingIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: 360.0 * pi / 180.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          if (mounted) _controller.reset();
          if (mounted) _controller.forward();
        }
      },
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
      animation: _controller,
      child: Icon(
        Icons.refresh,
        size: 128.0,
      ),
      builder: (context, child) => Transform.rotate(
        angle: _animation.value,
        child: child,
      ),
    );
  }
}
