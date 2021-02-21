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
  Duration pageChangeDuration;

  @override
  void initState() {
    super.initState();
    currentPageIndex = 0;
    pageController = PageController();
    pageChangeDuration = Duration(milliseconds: 200);
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
    onPageChanged(index);
    pageController.animateToPage(
      index,
      duration: pageChangeDuration,
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState((){});
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0
                child: Text(
                  "Refresh",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          )
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          FormulaePage(),
          CasksPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: FormulaePage.name,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: CasksPage.name,
          ),
        ],
      ),
    );
  }
}
