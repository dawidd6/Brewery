import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingTile<T> extends StatelessWidget {
  final String title;
  final String subtitle;
  final double? value;
  final double? min;
  final double? max;
  final bool? toggled;
  final bool enabled;
  final void Function(bool)? onSwitchChanged;
  final void Function(double)? onSliderChanged;

  SettingTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.toggled,
    required this.onSwitchChanged,
    this.enabled = true,
  })  : value = null,
        min = null,
        max = null,
        onSliderChanged = null,
        super(key: key);

  SettingTile.slider({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.min,
    required this.max,
    required this.onSliderChanged,
    this.enabled = true,
  })  : toggled = null,
        onSwitchChanged = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleWidget = Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: BreweryTheme.settingTileTitle,
      ),
    );
    final subtitleWidget = Text(
      subtitle,
      style: BreweryTheme.settingTileSubtitle,
    );
    final opacity = enabled ? 1.0 : 0.4;
    final padding = EdgeInsets.all(20.0);
    final duration = Duration(milliseconds: 500);

    if (onSliderChanged != null) {
      return AnimatedOpacity(
        opacity: opacity,
        duration: duration,
        child: ListTile(
          contentPadding: padding,
          title: titleWidget,
          subtitle: subtitleWidget,
          trailing: FittedBox(
            child: Row(
              children: [
                Slider(
                  value: value!,
                  min: min!,
                  max: max!,
                  divisions: (max! - min!).toInt(),
                  label: value!.toInt().toString(),
                  onChanged: enabled ? onSliderChanged : null,
                ),
                Text(
                  value!.toInt().toString(),
                  style: BreweryTheme.settingTileSubtitle,
                )
              ],
            ),
          ),
        ),
      );
    }

    return AnimatedOpacity(
      opacity: opacity,
      duration: duration,
      child: SwitchListTile(
        contentPadding: padding,
        value: toggled!,
        onChanged: enabled ? onSwitchChanged : null,
        title: titleWidget,
        subtitle: subtitleWidget,
      ),
    );
  }
}
