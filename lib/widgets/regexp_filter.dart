import 'package:brewery/widgets/conditional_widget.dart';
import 'package:flutter/material.dart';

class RegexpFilter extends StatefulWidget {
  final void Function(String) onChanged;
  final String title;

  RegexpFilter({
    Key? key,
    required this.title,
    required this.onChanged,
  });

  @override
  _RegexpFilterState createState() => _RegexpFilterState();
}

class _RegexpFilterState extends State<RegexpFilter> {
  final _controller = TextEditingController();

  void onClear() {
    _controller.clear();
    widget.onChanged('');
  }

  void onInput(String input) {
    widget.onChanged(input);
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: onInput,
      decoration: InputDecoration(
        labelText: widget.title,
        prefixIcon: Icon(
          Icons.search,
          size: 24.0,
          color: Theme.of(context).inputDecorationTheme.labelStyle!.color,
        ),
        suffixIcon: ConditionalWidget.nullable(
          condition: _controller.text.isNotEmpty,
          widgetIfTrue: IconButton(
            onPressed: onClear,
            icon: Icon(
              Icons.clear,
              size: 24.0,
              color: Theme.of(context).inputDecorationTheme.labelStyle!.color,
            ),
          ),
        ),
      ),
    );
  }
}
