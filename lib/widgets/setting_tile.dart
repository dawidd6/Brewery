import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool toggled;
  final void Function(bool) onChanged;

  SettingTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.toggled,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: toggled,
      onChanged: onChanged,
      title: Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(
          title,
          style: BreweryTheme.listTileTitle,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: BreweryTheme.listTileSubtitle,
      ),
    );
  }
}
