import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingSection extends StatelessWidget {
  final String header;

  SettingSection({
    Key? key,
    required this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          header,
          style: BreweryTheme.settingCategory,
        ),
      ),
    );
  }
}
