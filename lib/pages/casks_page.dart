import 'package:brewery/animations/scale_animation.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/pages/cask_page.dart';
import 'package:brewery/services/api.dart';
import 'package:flutter/material.dart';

class CasksPage extends StatefulWidget {
  static final String name = "Casks";

  CasksPage({Key key}) : super(key: key);

  @override
  CasksPageState createState() => CasksPageState();
}

class CasksPageState extends State<CasksPage>
    with AutomaticKeepAliveClientMixin {
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
      title: Text(
        cask.token,
        style: Theme.of(context).textTheme.headline1,
      ),
      subtitle: Text(
        cask.description,
        style: Theme.of(context).textTheme.headline2,
      ),
      trailing: Text(
        cask.version,
        style: Theme.of(context).textTheme.headline3,
      ),
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

  Widget buildError(Object error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          error.toString(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget buildLoading() {
    return ScaleAnimation(
      child: Icon(Icons.refresh),
      duration: Duration(milliseconds: 500),
      interval: Duration(milliseconds: 1000),
      loop: true,
    );
  }

  Widget buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState != ConnectionState.done) return buildLoading();
    if (snapshot.hasData) return buildRefresh(snapshot.data);
    if (snapshot.hasError) return buildError(snapshot.error);
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
