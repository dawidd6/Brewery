import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class TextSection extends StatelessWidget {
  final String header;
  final String body;

  TextSection({
    Key? key,
    required this.header,
    required this.body,
  }) : super(key: key);

  void _onLinkClick(LinkableElement link) async {
    if (link is UrlElement) {
      if (await canLaunch(link.url)) {
        await launch(link.url);
      } else {
        throw Exception('Could not launch $link');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: body.isNotEmpty,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: BreweryTheme.sectionHeader,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Divider(),
          ),
          Linkify(
            text: body,
            style: BreweryTheme.sectionBody,
            linkStyle: BreweryTheme.sectionBodyLink,
            options: LinkifyOptions(humanize: false),
            onOpen: _onLinkClick,
          ),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }
}
