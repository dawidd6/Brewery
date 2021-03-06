import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkSection extends StatelessWidget {
  final String header;
  final String link;

  LinkSection({
    Key? key,
    required this.header,
    required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (link.isEmpty) {
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
        InkWell(
          onTap: () => launch(link),
          child: Text(
            link,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}
