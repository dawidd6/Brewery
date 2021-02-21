import 'package:brewery/models/formula.dart';
import 'package:brewery/pages/common_page.dart';
import 'package:brewery/pages/formula_page.dart';
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
    futureFormulae = API.fetchFormulae();
  }

  Widget buildTile(Formula formula) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return FormulaPage(formula: formula);
            },
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
      itemBuilder: (context, index) {
        return buildTile(formulae[index]);
      },
    );
  }

  Widget buildRefresh(List<Formula> formulae) {
    return RefreshIndicator(
      onRefresh: () {
        futureFormulae = API.fetchFormulae();
        return futureFormulae;
      },
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
