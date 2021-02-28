import 'package:brewery/animations/rotate_animation.dart';
import 'package:flutter/material.dart';

class LoadingIcon extends StatelessWidget {
  LoadingIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotateAnimation(
      child: Icon(
        Icons.refresh,
        size: 128.0,
      ),
      duration: Duration(milliseconds: 500),
      interval: Duration(milliseconds: 100),
      loop: true,
    );
  }
}
