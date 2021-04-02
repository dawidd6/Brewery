import 'package:brewery/blocs/settings/settings_bloc.dart';
import 'package:brewery/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  static const route = '/settings';

  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoadedState) {
            return ListView(
              itemExtent: 80.0,
              children: [
                SettingTile(
                  title: 'Enable search completions',
                  subtitle:
                      'Show a box below search bar with previously entered queries',
                  toggled: state.enableCompletions,
                  onSwitchChanged: (toggled) => bloc.add(
                    SettingsEnableCompletionsEvent(enabled: toggled),
                  ),
                ),
                SettingTile.slider(
                  title: 'Search completion history',
                  subtitle: 'How much queries should be remembered',
                  value: state.completionsHistory.toDouble(),
                  min: 0,
                  max: 10,
                  onSliderChanged: (value) => bloc.add(
                    SettingsCompletionsHistoryEvent(history: value.toInt()),
                  ),
                  enabled: state.enableCompletions,
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
