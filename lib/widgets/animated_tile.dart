import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String trailing;
  final RegExp filter;
  final void Function() onTap;

  AnimatedTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.filter,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedTileState createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
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
    final spans = <TextSpan>[];

    if (widget.filter.pattern.isEmpty) {
      spans.add(TextSpan(text: widget.title));
    } else {
      widget.title.splitMapJoin(widget.filter, onMatch: (match) {
        spans.add(TextSpan(
          text: match.group(0),
          style: Theme.of(context).textTheme.headline6,
        ));
        return '';
      }, onNonMatch: (str) {
        spans.add(TextSpan(text: str));
        return '';
      });
    }

    return FadeTransition(
      opacity: _animation,
      child: ListTile(
        onTap: widget.onTap,
        title: Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text.rich(
            TextSpan(
              children: spans,
            ),
            style: Theme.of(context).textTheme.headline1,
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
        ),
        subtitle: Text(
          widget.subtitle,
          style: Theme.of(context).textTheme.headline2,
          overflow: TextOverflow.fade,
          softWrap: false,
          maxLines: 1,
        ),
        trailing: Text(
          widget.trailing,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
