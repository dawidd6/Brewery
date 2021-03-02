import 'package:brewery/icons/brewery_icons.dart';
import 'package:brewery/pages/casks_page.dart';
import 'package:brewery/pages/formulae_page.dart';
import 'package:brewery/pages/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static final route = "/";

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO bloc it
  int currentPageIndex = 0;
  PageController pageController = PageController();

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
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void onSelected(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, SettingsPage.route);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brewery"),
        actions: [
          PopupMenuButton(
            onSelected: onSelected,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  "Settings",
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
            icon: Padding(
              padding: EdgeInsets.only(bottom: 3.0),
              child: Icon(BreweryIcons.recipe_book),
            ),
            label: FormulaePage.name,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 3.0),
              child: Icon(BreweryIcons.wine_cask),
            ),
            label: CasksPage.name,
          ),
        ],
      ),
    );
  }
}
