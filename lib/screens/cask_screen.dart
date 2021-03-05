import 'package:brewery/models/cask.dart';
import 'package:flutter/material.dart';

class CaskScreen extends StatelessWidget {
  final Cask cask;
  final List<Cask> casks;

  CaskScreen({
    Key? key,
    required this.cask,
    required this.casks,
  }) : super(key: key);

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
