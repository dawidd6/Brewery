import 'package:flutter/material.dart';

class RegexpFilter extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) callback;

  RegexpFilter({Key key, this.controller, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        onChanged: callback,
        decoration: InputDecoration(
          labelText: "Regexp filter",
        ),
      ),
    );
  }
}
