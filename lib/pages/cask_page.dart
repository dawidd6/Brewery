import 'package:brewery/models/cask.dart';
import 'package:flutter/material.dart';

class CaskPage extends StatelessWidget {
  final Cask cask;

  CaskPage({Key key, @required this.cask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cask.token),
      ),
      body: Placeholder(),
    );
  }
}
