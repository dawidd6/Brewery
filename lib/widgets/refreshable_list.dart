import 'package:brewery/widgets/animated_tile.dart';
import 'package:flutter/material.dart';

class RefreshableList<T> extends StatelessWidget {
  final Widget Function(T) pageBuilder;
  final String Function(T) tileTitleBuilder;
  final String Function(T) tileSubtitleBuilder;
  final String Function(T) tileTrailingBuilder;
  final RefreshCallback onRefresh;
  final List<T> itemList;

  RefreshableList({
    Key? key,
    required this.pageBuilder,
    required this.tileTitleBuilder,
    required this.tileSubtitleBuilder,
    required this.tileTrailingBuilder,
    required this.onRefresh,
    required this.itemList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: itemList.length,
          itemBuilder: (context, index) => AnimatedTile(
            title: tileTitleBuilder(itemList[index]),
            subtitle: tileSubtitleBuilder(itemList[index]),
            trailing: tileTrailingBuilder(itemList[index]),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => pageBuilder(itemList[index])),
            ),
          ),
        ),
      ),
    );
  }
}
