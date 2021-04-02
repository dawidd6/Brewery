import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/material.dart';

class RegexpFilter extends StatefulWidget {
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final Iterable<String> Function(TextEditingValue)? optionsBuilder;
  final String title;
  final bool focus;

  RegexpFilter({
    Key? key,
    required this.title,
    this.onChanged,
    this.optionsBuilder,
    this.onTap,
    this.onSubmitted,
    this.focus = false,
  });

  @override
  _RegexpFilterState createState() => _RegexpFilterState();
}

class _RegexpFilterState extends State<RegexpFilter> {
  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      onSelected: widget.onChanged,
      optionsBuilder: widget.optionsBuilder ?? (_) => [],
      optionsViewBuilder: (context, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(10.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 200,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(8.0),
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text(
                  options.elementAt(index),
                  style: BreweryTheme.inputCompletions,
                ),
                onTap: () => onSelected(options.elementAt(index)),
              ),
            ),
          ),
        ),
      ),
      fieldViewBuilder: (context, controller, node, onSubmit) => TextField(
        autofocus: widget.focus,
        focusNode: node,
        controller: controller,
        onChanged: (input) {
          if (widget.onChanged != null) {
            widget.onChanged!(input);
          }
          setState(() {});
        },
        onSubmitted: widget.onSubmitted,
        onTap: widget.onTap,
        style: BreweryTheme.searchBarText,
        decoration: InputDecoration(
          labelText: widget.title,
          prefixIcon: Icon(
            Icons.search,
            size: 24.0,
            color: Theme.of(context).inputDecorationTheme.labelStyle!.color,
          ),
          suffixIcon: Visibility(
            visible: controller.text.isNotEmpty,
            child: IconButton(
              onPressed: () {
                controller.clear();
                if (widget.onChanged != null) {
                  widget.onChanged!('');
                }
                setState(() {});
              },
              hoverColor: Colors.transparent,
              icon: Icon(
                Icons.clear,
                size: 24.0,
                color: Theme.of(context).inputDecorationTheme.labelStyle!.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
