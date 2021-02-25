import 'package:brewery/animations/scale.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/pages/formula.dart';
import 'package:brewery/services/api.dart';
import 'package:flutter/material.dart';

class FormulaePage extends StatefulWidget {
  static final String name = "Formulae";

  FormulaePage({Key key}) : super(key: key);

  @override
  FormulaePageState createState() => FormulaePageState();
}

class FormulaePageState extends State<FormulaePage>
    with AutomaticKeepAliveClientMixin {
  Future<List<dynamic>> futureList;
  String filter;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future refresh() => futureList = API.fetchFormulae();

  Widget page(dynamic obj) => FormulaPage(formula: obj);

  String title(dynamic obj) => (obj as Formula).name;

  String subtitle(dynamic obj) => (obj as Formula).description;

  String trailing(dynamic obj) => (obj as Formula).version;

  bool desired(dynamic obj) => (obj as Formula).name.startsWith(filter ?? "");

  void navigate(dynamic obj) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page(obj),
        ),
      );

  Widget buildError(BuildContext context, Object error) {
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

  Widget buildTile(dynamic obj) {
    return ListTile(
      onTap: () => navigate(obj),
      title: Text(
        title(obj),
        style: Theme.of(context).textTheme.headline1,
      ),
      subtitle: Text(
        subtitle(obj),
        style: Theme.of(context).textTheme.headline2,
      ),
      trailing: Text(
        trailing(obj),
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget buildList(List<dynamic> list) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: list.length,
        itemBuilder: (context, index) => buildTile(list[index]),
      ),
    );
  }

  Widget buildRefresh(List<dynamic> list) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "Search",
            contentPadding: EdgeInsets.all(2.0),
            icon: Icon(
              Icons.search,
            ),
          ),
          onChanged: (input) {
            setState(() {
              filter = input;
              futureList = futureList;
            });
          },
        ),
        Expanded(
          child: buildList(list),
        ),
      ],
    );
  }

  Widget futureBuilder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState != ConnectionState.done) return buildLoading();
    if (snapshot.hasData) return buildRefresh(snapshot.data);
    if (snapshot.hasError) return buildError(context, snapshot.error);
    return buildError(context, "No data");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<dynamic>>(
      future: futureList,
      builder: futureBuilder,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
