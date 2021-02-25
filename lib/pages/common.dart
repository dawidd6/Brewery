import 'package:brewery/animations/scale.dart';
import 'package:flutter/material.dart';

mixin CommonPageMixin {
  Widget buildTileTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline1,
    );
  }

  Widget buildTileSubtitle(BuildContext context, String subtitle) {
    return Text(
      subtitle,
      style: Theme.of(context).textTheme.headline2,
    );
  }

  Widget buildTileTrailing(BuildContext context, String trailing) {
    return Text(
      trailing,
      style: Theme.of(context).textTheme.headline3,
    );
  }

  Widget buildError(BuildContext context, Object error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          error.toString(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget buildLoading() {
    return ScaleAnimation(
      child: Icon(Icons.refresh),
      duration: Duration(milliseconds: 500),
      interval: Duration(milliseconds: 1000),
      loop: true,
    );
  }
}
