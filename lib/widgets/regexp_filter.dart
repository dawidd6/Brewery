import 'package:flutter/material.dart';

class RegexpFilter extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final int filteredCount;
  final int totalCount;

  RegexpFilter({Key key, this.controller, this.onChanged, this.filteredCount, this.totalCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: "Regexp filter",
          counterText: "$filteredCount / $totalCount",
        ),
      ),
    );
  }
}
