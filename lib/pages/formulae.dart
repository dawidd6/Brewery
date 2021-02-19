import 'package:brewery/animations/scale.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/services/api.dart';
import 'package:flutter/material.dart';

class BreweryFormulaePage extends StatefulWidget {
  BreweryFormulaePage({Key key}) : super(key: key);

  @override
  BreweryFormulaePageState createState() => BreweryFormulaePageState();
}

class BreweryFormulaePageState extends State<BreweryFormulaePage>
    with AutomaticKeepAliveClientMixin {
  Future<List<Formula>> futureFormula;

  @override
  void initState() {
    super.initState();
    fetchFormula();
  }

  void fetchFormula() {
    futureFormula = API.fetchFormula();
  }

  Widget buildFormulaList(List<Formula> formulae) {
    return RefreshIndicator(
      onRefresh: () {
        fetchFormula();
        return futureFormula;
      },
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: formulae.length,
        itemBuilder: (context, index) {
          Formula formula = formulae[index];
          return ListTile(
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

  Widget buildFutureFormula(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) return buildFormulaList(snapshot.data);
    if (snapshot.hasError) return buildError(snapshot.error);
    return buildLoading();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<Formula>>(
      future: futureFormula,
      builder: buildFutureFormula,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
