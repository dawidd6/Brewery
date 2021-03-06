import 'package:flutter/material.dart';

class RegexpFilter extends StatelessWidget {
  final void Function(String) onChanged;
  final TextEditingController controller;
  final String title;

  RegexpFilter({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          size: 24.0,
          color: Theme.of(context).inputDecorationTheme.labelStyle!.color,
        ),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
                icon: Icon(
                  Icons.clear,
                  size: 24.0,
                  color:
                      Theme.of(context).inputDecorationTheme.labelStyle!.color,
                ),
              ),
        labelText: title,
      ),
    );
  }
}
