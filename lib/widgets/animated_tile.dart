import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String trailing;
  final void Function() onTap;

  AnimatedTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.trailing,
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
    return FadeTransition(
      opacity: _animation,
      child: ListTile(
        onTap: widget.onTap,
        title: Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.headline1,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        subtitle: Text(
          widget.subtitle,
          style: Theme.of(context).textTheme.headline2,
          overflow: TextOverflow.ellipsis,
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
