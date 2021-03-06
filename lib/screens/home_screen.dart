import 'package:brewery/blocs/home_bloc.dart';
import 'package:brewery/blocs/settings_bloc.dart';
import 'package:brewery/pages/casks_page.dart';
import 'package:brewery/pages/formulae_page.dart';
import 'package:brewery/screens/settings_screen.dart';
import 'package:brewery/styles/brewery_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text('Brewery'),
          actions: [
            PopupMenuButton(
              onSelected: (index) {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                            SettingsBloc()..add(SettingsLoadEvent()),
                        child: SettingsScreen(),
                      ),
                    ),
                  );
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Text(
                    'Settings',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            )
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) => BlocProvider.of<HomeBloc>(context)
              .add(HomeChangePageEvent(index)),
          children: [
            FormulaePage(),
            CasksPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: (state as HomePageState).index,
          onTap: (index) => _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOut,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(BreweryIcons.recipe_book),
              ),
              label: FormulaePage.name,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(BreweryIcons.wine_cask),
              ),
              label: CasksPage.name,
            ),
          ],
        ),
      ),
    );
  }
}