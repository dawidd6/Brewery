import 'package:brewery/screens/casks_screen.dart';
import 'package:brewery/screens/formulae_casks_screen.dart';
import 'package:brewery/screens/formulae_screen.dart';
import 'package:brewery/screens/settings_screen.dart';
import 'package:brewery/styles/brewery_images.dart';
import 'package:brewery/widgets/material_hero.dart';
import 'package:brewery/widgets/menu_button.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brewery'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed(
              SettingsScreen.route,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                SvgPicture.asset(
                  BreweryImages.iconPath,
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 40),
                MaterialHero(
                  tag: 'search',
                  child: RegexpFilter(
                    title: 'Search formulae and casks',
                    onChanged: (filter) {},
                    onTap: () => Navigator.of(context).pushNamed(
                      FormulaeCasksScreen.route,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                MenuButton(
                  label: 'Formulae',
                  onClick: () => Navigator.of(context).pushNamed(
                    FormulaeScreen.route,
                  ),
                ),
                SizedBox(height: 20),
                MenuButton(
                  label: 'Casks',
                  onClick: () => Navigator.of(context).pushNamed(
                    CasksScreen.route,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
