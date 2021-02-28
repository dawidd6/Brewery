import 'package:brewery/animations/scale_animation.dart';
import 'package:flutter/material.dart';

class LoadingIcon extends StatelessWidget {
  LoadingIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimation(
      child: Icon(
        Icons.refresh,
        size: 128.0,
      ),
      duration: Duration(milliseconds: 500),
      interval: Duration(milliseconds: 1000),
      loop: true,
    );
  }
}
