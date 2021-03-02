import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool toggled;
  final void Function(bool) onChanged;

  SettingTile({
    Key key,
    this.title,
    this.subtitle,
    this.toggled,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.headline2,
      ),
      trailing: Switch(
        value: toggled,
        onChanged: onChanged,
      ),
    );
  }
}
