import 'package:brewery/animations/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      style: Theme.of(context).textTheme.headline1,
    );
  }

  Widget buildTileTrailing(BuildContext context, String trailing) {
    return Text(
      trailing,
      style: Theme.of(context).textTheme.headline1,
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
      child: SvgPicture.asset(
        "assets/icons/icon.svg",
        width: 64,
        height: 64,
      ),
      duration: Duration(milliseconds: 500),
      interval: Duration(milliseconds: 1000),
      loop: true,
    );
  }
}
