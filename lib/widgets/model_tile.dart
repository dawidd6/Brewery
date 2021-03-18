import 'package:brewery/styles/brewery_theme.dart';
import 'package:brewery/widgets/highlighted_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ModelTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String trailing;
  final Widget? leading;
  final RegExp? filter;
  final void Function() onTap;

  ModelTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
    this.filter,
    this.leading,
  }) : super(key: key);

  @override
  _ModelTileState createState() => _ModelTileState();
}

class _ModelTileState extends State<ModelTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: ListTile(
        onTap: widget.onTap,
        title: Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: HighlightedText(
            text: widget.title,
            filter: widget.filter,
            style: BreweryTheme.listTileTitle,
            highlightStyle: BreweryTheme.listTileTitleHighlighted,
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
        ),
        subtitle: Text(
          widget.subtitle,
          style: BreweryTheme.listTileSubtitle,
          overflow: TextOverflow.fade,
          softWrap: false,
          maxLines: 1,
        ),
        trailing: Text(
          widget.trailing,
          style: BreweryTheme.listTileTrailing,
        ),
        leading: widget.leading,
      ),
    );
  }
}
