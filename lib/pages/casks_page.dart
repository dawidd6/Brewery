import 'package:brewery/models/cask.dart';
import 'package:brewery/pages/cask_page.dart';
import 'package:brewery/pages/common_page.dart';
import 'package:brewery/services/api.dart';
import 'package:flutter/material.dart';

class CasksPage extends StatefulWidget {
  static final String name = "Casks";

  CasksPage({Key key}) : super(key: key);

  @override
  CasksPageState createState() => CasksPageState();
}

class CasksPageState extends State<CasksPage>
    with AutomaticKeepAliveClientMixin, CommonPageMixin {
  Future<List<Cask>> futureCasks;

  @override
  void initState() {
    super.initState();
    futureCasks = API.fetchCasks();
  }

  Widget buildTile(Cask cask) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CaskPage(cask: cask);
            },
          ),
        );
      },
      title: buildTileTitle(context, cask.token),
      subtitle: buildTileSubtitle(context, cask.description),
      trailing: buildTileTrailing(context, cask.version),
    );
  }

  Widget buildList(List<Cask> casks) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: casks.length,
      itemBuilder: (context, index) {
        return buildTile(casks[index]);
      },
    );
  }

  Widget buildRefresh(List<Cask> casks) {
    return RefreshIndicator(
      onRefresh: () {
        futureCasks = API.fetchCasks();
        return futureCasks;
      },
      child: buildList(casks),
    );
  }

  Widget buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState != ConnectionState.done) return buildLoading();
    if (snapshot.hasData) return buildRefresh(snapshot.data);
    if (snapshot.hasError) return buildError(context, snapshot.error);
    return buildLoading();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<Cask>>(
      future: futureCasks,
      builder: buildFuture,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
