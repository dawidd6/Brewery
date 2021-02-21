import 'package:brewery/pages/casks_page.dart';
import 'package:brewery/pages/formulae_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, @required this.title}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentPageIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    currentPageIndex = 0;
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  void onTap(int index) {
    setState(() {
      currentPageIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: [
            FormulaePage(),
            CasksPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: onTap,
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
