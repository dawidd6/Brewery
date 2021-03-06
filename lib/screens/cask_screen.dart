import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/widgets/text_section.dart';
import 'package:flutter/material.dart';

class CaskScreen extends StatelessWidget {
  final Cask cask;

  CaskScreen({
    Key? key,
    required this.cask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cask.token),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          TextSection(header: 'Description', body: cask.description),
          TextSection(header: 'Version', body: cask.version),
        ],
      ),
    );
  }
}
