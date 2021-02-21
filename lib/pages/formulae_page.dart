import 'package:brewery/animations/scale_animation.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/pages/formula_page.dart';
import 'package:brewery/services/api.dart';
import 'package:flutter/material.dart';

class FormulaePage extends StatefulWidget {
  FormulaePage({Key key}) : super(key: key);

  @override
  FormulaePageState createState() => FormulaePageState();
}

class FormulaePageState extends State<FormulaePage>
    with AutomaticKeepAliveClientMixin {
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
      title: Text(
        formula.name,
        style: Theme.of(context).textTheme.headline1,
      ),
      subtitle: Text(
        formula.description,
        style: Theme.of(context).textTheme.headline2,
      ),
      trailing: Text(
        formula.version,
        style: Theme.of(context).textTheme.headline3,
      ),
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

  Widget buildError(Object error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          error.toString(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Divider(
          height: 20,
        ),
        ElevatedButton(
          child: Text(
            "RELOAD",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          onPressed: () {
            setState(() {
              futureFormulae = API.fetchFormulae();
            });
          },
        )
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
    return FutureBuilder<List<Formula>>(
      future: futureFormulae,
      builder: buildFuture,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
