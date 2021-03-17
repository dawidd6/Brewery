import 'package:brewery/widgets/model_tile.dart';
import 'package:flutter/material.dart';

class ModelList<T> extends StatelessWidget {
  final String Function(T) tileTitleBuilder;
  final String Function(T) tileSubtitleBuilder;
  final String Function(T) tileTrailingBuilder;
  final Widget? Function(T)? tileLeadingBuilder;
  final void Function(T) onTileClick;
  final List<T> itemList;
  final RegExp? filter;

  ModelList({
    Key? key,
    required this.tileTitleBuilder,
    required this.tileSubtitleBuilder,
    required this.tileTrailingBuilder,
    required this.onTileClick,
    required this.itemList,
    this.filter,
    this.tileLeadingBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: itemList.length,
        itemExtent: 80.0,
        itemBuilder: (context, index) => ModelTile(
          filter: filter,
          title: tileTitleBuilder(itemList[index]),
          subtitle: tileSubtitleBuilder(itemList[index]),
          trailing: tileTrailingBuilder(itemList[index]),
          leading: tileLeadingBuilder != null
              ? tileLeadingBuilder!(itemList[index])
              : null,
          onTap: () => onTileClick(itemList[index]),
        ),
      ),
    );
  }
}
