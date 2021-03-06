import 'package:brewery/blocs/settings_bloc.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) => CenterSwitcher(
          builder: (context) {
            if (state is SettingsReadyState) {
              return ListView(
                children: [
                  BlocBuilder<SettingsTestCubit, bool>(
                    bloc: BlocProvider.of<SettingsBloc>(context).test,
                    builder: (context, state) => SettingTile(
                      title: 'Test setting',
                      subtitle: 'Test description',
                      toggled: state,
                      onChanged: (value) =>
                          BlocProvider.of<SettingsBloc>(context)
                              .test
                              .set(value),
                    ),
                  ),
                ],
              );
            } else if (state is SettingsErrorState) {
              return FailureText(
                message: state.error.toString(),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}