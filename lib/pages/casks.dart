import 'package:brewery/animations/scale.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/services/api.dart';
import 'package:flutter/material.dart';

class BreweryCasksPage extends StatefulWidget {
  BreweryCasksPage({Key key}) : super(key: key);

  @override
  BreweryCasksPageState createState() => BreweryCasksPageState();
}

class BreweryCasksPageState extends State<BreweryCasksPage>
    with AutomaticKeepAliveClientMixin {
  Future<List<Cask>> futureCask;

  @override
  void initState() {
    super.initState();
    fetchCask();
  }

  void fetchCask() {
    futureCask = API.fetchCask();
  }

  Widget buildCaskList(List<Cask> casks) {
    return RefreshIndicator(
      onRefresh: () {
        fetchCask();
        return futureCask;
      },
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: casks.length,
        itemBuilder: (context, index) {
          Cask cask = casks[index];
          return ListTile(
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
        },
      ),
    );
  }

  Widget buildLoading() {
    return InfiniteScaleAnimation(
      child: Icon(Icons.refresh),
      duration: Duration(milliseconds: 500),
      interval: Duration(milliseconds: 1000),
    );
  }

  Widget buildError(Object error) {
    return Text(
      error.toString(),
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Widget buildFutureCask(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) return buildCaskList(snapshot.data);
    if (snapshot.hasError) return buildError(snapshot.error);
    return buildLoading();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<Cask>>(
      future: futureCask,
      builder: buildFutureCask,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
