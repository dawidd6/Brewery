import 'package:brewery/models/formula.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/services/api.dart';
import 'package:flutter/material.dart';

class BreweryHomePage extends StatefulWidget {
  final String title;

  BreweryHomePage({Key key, @required this.title}) : super(key: key);

  @override
  BreweryHomePageState createState() => BreweryHomePageState();
}

class BreweryHomePageState extends State<BreweryHomePage> {
  int currentPageIndex = 0;
  PageController pageController = PageController();
  API api = API();
  Future<List<Formula>> futureFormula;
  Future<List<Cask>> futureCask;

  void fetchFormula() {
    futureFormula = api.fetchFormula();
  }

  void fetchCask() {
    futureCask = api.fetchCask();
  }

  @override
  void initState() {
    super.initState();
    fetchFormula();
    fetchCask();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        children: [
          RefreshIndicator(
            child: FutureBuilder<List<Formula>>(
              future: futureFormula,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data[index].name,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  // TODO
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
            onRefresh: () {
              fetchFormula();
              return futureFormula;
            },
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(""),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Formulae",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Casks",
          ),
        ],
      ),
    );
  }
}
