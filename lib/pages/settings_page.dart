import 'package:brewery/blocs/settings_bloc.dart';
import 'package:brewery/events/settings_events.dart';
import 'package:brewery/states/settings_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  static final route = "/settings";

  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(SettingsLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) => AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: () {
            if (state is SettingsReadyState)
              return ListView(
                children: [
                  ListTile(
                    title: Text("Test setting"),
                    subtitle: Text("Test description"),
                    trailing: Switch(
                      value: state.testValue,
                      onChanged: (value) => context
                          .read<SettingsBloc>()
                          .add(SettingsSetTestEvent(value)),
                    ),
                  ),
                ],
              );
          }(),
        ),
      ),
    );
  }
}
