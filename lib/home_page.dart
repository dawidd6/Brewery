import 'package:flutter/material.dart';

class BreweryHomePage extends StatefulWidget {
  final String title;

  BreweryHomePage({Key key, @required this.title}) : super(key: key);

  @override
  BreweryHomePageState createState() => BreweryHomePageState();
}

class BreweryHomePageState extends State<BreweryHomePage> {
  PageController pageController = PageController();
  int currentPageIndex = 0;

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
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(""),
              );
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
