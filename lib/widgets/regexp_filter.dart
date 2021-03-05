import 'package:flutter/material.dart';

class RegexpFilter extends StatelessWidget {
  final void Function(String) onChanged;
  final int filteredCount;
  final int totalCount;
  final TextEditingController controller;

  RegexpFilter({
    Key? key,
    required this.onChanged,
    required this.filteredCount,
    required this.totalCount,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextField(
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
                    color: Theme.of(context)
                        .inputDecorationTheme
                        .labelStyle!
                        .color,
                  ),
                ),
          labelText: 'Regexp search',
          counterText: '$filteredCount / $totalCount',
        ),
      ),
    );
  }
}
