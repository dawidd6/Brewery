import 'package:flutter/material.dart';
//import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class LoadingBeer extends StatefulWidget {
  LoadingBeer({Key? key}) : super(key: key);

  @override
  _LoadingBeerState createState() => _LoadingBeerState();
}

class _LoadingBeerState extends State<LoadingBeer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _controller.repeat(reverse: true);
  }

  Path path(double width) {
    final path = Path();
    final mainRect = Rect.fromPoints(
      Offset(width * 0.20, 0.0),
      Offset(width * 0.80, width),
    );
    final extraRect = Rect.fromPoints(
      Offset(width * 0.6, width * 0.25),
      Offset(width, width * 0.75),
    );
    path.addRRect(RRect.fromRectAndRadius(mainRect, Radius.circular(10.0)));
    path.addRRect(RRect.fromRectAndRadius(extraRect, Radius.circular(10.0)));
    path.close();
    return path;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.shortestSide * 0.4;
    return SizedBox(
      width: width,
      height: width,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) =>
            Container(), /*LiquidCustomProgressIndicator(
          value: _controller.value,
          direction: Axis.vertical,
          shapePath: path(width),
          center: Text('Brewing...'),),*/
      ),
    );
  }
}
