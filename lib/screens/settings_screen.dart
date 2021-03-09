import 'package:brewery/blocs/settings/settings_cubit.dart';
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
      body: ListView(
        children: [
          BlocBuilder<SettingsTestCubit, bool>(
            builder: (context, state) => SettingTile(
              title: 'Test setting',
              subtitle: 'Test description',
              toggled: state,
              onChanged: BlocProvider.of<SettingsTestCubit>(context).set,
            ),
          ),
        ],
      ),
    );
  }
}
