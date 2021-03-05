import 'package:brewery/widgets/animated_tile.dart';
import 'package:flutter/material.dart';

class RefreshableList<T> extends StatelessWidget {
  final String Function(T) tileTitleBuilder;
  final String Function(T) tileSubtitleBuilder;
  final String Function(T) tileTrailingBuilder;
  final void Function(T) onTileClick;
  final RefreshCallback onRefresh;
  final List<T> itemList;
  final RegExp filter;

  RefreshableList({
    Key? key,
    required this.tileTitleBuilder,
    required this.tileSubtitleBuilder,
    required this.tileTrailingBuilder,
    required this.onTileClick,
    required this.onRefresh,
    required this.itemList,
    required this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView.builder(
            itemCount: itemList.length,
            itemExtent: 80.0,
            itemBuilder: (context, index) => AnimatedTile(
              filter: filter,
              title: tileTitleBuilder(itemList[index]),
              subtitle: tileSubtitleBuilder(itemList[index]),
              trailing: tileTrailingBuilder(itemList[index]),
              onTap: () => onTileClick(itemList[index]),
            ),
          ),
        ),
      ),
    );
  }
}
