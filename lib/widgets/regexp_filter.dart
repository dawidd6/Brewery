import 'package:brewery/widgets/conditional_widget.dart';
import 'package:brewery/styles/brewery_theme.dart
import 'package:flutter/material.dart';

class RegexpFilter extends StatefulWidget {
  final void Function()? onTap;
  final void Function(String) onChanged;
  final String title;
  final bool focus;

  RegexpFilter({
    Key? key,
    required this.title,
    required this.onChanged,
    this.onTap,
    this.focus = false,
  });

  @override
  _RegexpFilterState createState() => _RegexpFilterState();
}

class _RegexpFilterState extends State<RegexpFilter> {
  final _controller = TextEditingController();

  void onClear() {
    _controller.clear();
    widget.onChanged('');
    setState(() {});
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
      autofocus: widget.focus,
      controller: _controller,
      onChanged: onInput,
      onTap: widget.onTap,
      style: BreweryTheme.searchBarText,
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
            hoverColor: Colors.transparent,
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
