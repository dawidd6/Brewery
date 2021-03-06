import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  final String header;
  final String body;

  TextSection({
    Key? key,
    required this.header,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (body.isEmpty) {
      return Container();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: Theme.of(context).textTheme.headline4,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Divider(),
        ),
        Text(
          body,
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}
