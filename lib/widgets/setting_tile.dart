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
    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
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
