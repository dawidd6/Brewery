import 'package:flutter/material.dart';

class FailureText extends StatelessWidget {
  final String message;
  final void Function()? onRefresh;

  FailureText({
    Key? key,
    required this.message,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onRefresh == null
            ? Container()
            : IconButton(
                icon: Icon(Icons.refresh),
                iconSize: MediaQuery.of(context).size.shortestSide * 0.2,
                onPressed: onRefresh,
              ),
        Text(
          '',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
