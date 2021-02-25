import 'package:brewery/models/formula.dart';
import 'package:brewery/pages/common.dart';
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
    with AutomaticKeepAliveClientMixin, CommonPageMixin {
  Future<List<Formula>> futureFormulae;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future refresh() {
    futureFormulae = API.fetchFormulae();
    return futureFormulae;
  }

  Widget buildTile(Formula formula) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormulaPage(formula: formula),
          ),
        );
      },
      title: buildTileTitle(context, formula.name),
      subtitle: buildTileSubtitle(context, formula.version),
      trailing: buildTileTrailing(context, formula.version),
    );
  }

  Widget buildList(List<Formula> formulae) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: formulae.length,
      itemBuilder: (context, index) => buildTile(formulae[index]),
    );
  }

  Widget buildRefresh(List<Formula> formulae) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: buildList(formulae),
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
    return FutureBuilder<List<Formula>>(
      future: futureFormulae,
      builder: buildFuture,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
