import 'package:brewery/blocs/settings/settings_bloc.dart';
import 'package:brewery/widgets/setting_section.dart';
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
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SettingSection(header: 'Completions'),
                    SettingTile(
                      title: 'Show box',
                      subtitle:
                          'Show a box below search bar with previously entered queries',
                      toggled: state.enableCompletions,
                      onSwitchChanged: (toggled) => bloc.add(
                        SettingsEnableCompletionsEvent(enabled: toggled),
                      ),
                    ),
                    SettingTile.slider(
                      title: 'History size',
                      subtitle: 'How much queries should be remembered',
                      value: state.completionsHistory.toDouble(),
                      min: 0,
                      max: 8,
                      onSliderChanged: (value) => bloc.add(
                        SettingsCompletionsHistoryEvent(history: value.toInt()),
                      ),
                      enabled: state.enableCompletions,
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
