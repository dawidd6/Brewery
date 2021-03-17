import 'package:brewery/widgets/material_hero.dart';
import 'package:brewery/widgets/menu_button.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brewery'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            SizedBox(height: 20),
            SvgPicture.asset(
              'icons/icon.svg',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 40),
            MaterialHero(
              tag: 'search',
              child: RegexpFilter(
                title: 'Search formulae and casks',
                onChanged: (filter) {},
                onTap: () => Navigator.of(context).pushNamed('/formulae_casks'),
              ),
            ),
            SizedBox(height: 20),
            MenuButton(
              label: 'Formulae',
              onClick: () => Navigator.of(context).pushNamed('/formulae'),
            ),
            SizedBox(height: 20),
            MenuButton(
              label: 'Casks',
              onClick: () => Navigator.of(context).pushNamed('/casks'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
