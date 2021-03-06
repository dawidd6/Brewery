import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaskScreen extends StatelessWidget {
  final Cask cask;

  CaskScreen({
    Key? key,
    required this.cask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CasksBloc>(context);
    final casks = (bloc.state as CasksLoadedState).casks;

    return Scaffold(
      appBar: AppBar(
        title: Text(cask.token),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [],
      ),
    );
  }
}
