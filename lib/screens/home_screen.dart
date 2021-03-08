import 'package:brewery/screens/casks_screen.dart';
import 'package:brewery/screens/formulae_screen.dart';
import 'package:brewery/screens/settings_screen.dart';
import 'package:brewery/widgets/material_hero.dart';
import 'package:brewery/widgets/menu_button.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brewery'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsScreen(),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 200,
              ),
              child: SvgPicture.asset(
                'icons/icon.svg',
              ),
            ),
            SizedBox(height: 40),
            MaterialHero(
              tag: 'search',
              child: RegexpFilter(
                title: 'Search formulae and casks',
                onChanged: (filter) {},
              ),
            ),
            SizedBox(height: 20),
            MenuButton(
              label: 'Formulae',
              pageBuilder: (context) => FormulaeScreen(),
            ),
            SizedBox(height: 20),
            MenuButton(
              label: 'Casks',
              pageBuilder: (context) => CasksScreen(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
