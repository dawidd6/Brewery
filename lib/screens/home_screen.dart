import 'package:brewery/widgets/material_hero.dart';
import 'package:brewery/widgets/menu_button.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vrouter/vrouter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brewery'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => VRouterData.of(context).push('/settings'),
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
              ),
            ),
            SizedBox(height: 20),
            MenuButton(
              label: 'Formulae',
              onClick: () => VRouterData.of(context).push('/formulae'),
            ),
            SizedBox(height: 20),
            MenuButton(
              label: 'Casks',
              onClick: () => VRouterData.of(context).push('/casks'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
