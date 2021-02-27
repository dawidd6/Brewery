import 'package:flutter/material.dart';

class RefreshableList<T> extends StatelessWidget {
  final Widget Function(T) pageBuilder;
  final String Function(T) tileTitleBuilder;
  final String Function(T) tileSubtitleBuilder;
  final String Function(T) tileTrailingBuilder;
  final RefreshCallback onRefresh;
  final List<T> itemList;

  RefreshableList({
    Key key,
    @required this.pageBuilder,
    @required this.tileTitleBuilder,
    @required this.tileSubtitleBuilder,
    @required this.tileTrailingBuilder,
    @required this.onRefresh,
    @required this.itemList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: itemList.length,
          itemBuilder: (context, index) => ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => pageBuilder(itemList[index])),
            ),
            title: Text(
              tileTitleBuilder(itemList[index]),
              style: Theme.of(context).textTheme.headline1,
            ),
            subtitle: Text(
              tileSubtitleBuilder(itemList[index]),
              style: Theme.of(context).textTheme.headline2,
            ),
            trailing: Text(
              tileTrailingBuilder(itemList[index]),
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      ),
    );
  }
}
