import 'package:brewery/viewmodels/settings_viewmodel.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final SettingsViewModel viewModel = SettingsViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ValueListenableBuilder(
        valueListenable: viewModel,
        builder: (context, _, child) => viewModel.preferences == null
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("test setting"),
                      Checkbox(
                        value: viewModel.getTest(),
                        onChanged: viewModel.setTest,
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
