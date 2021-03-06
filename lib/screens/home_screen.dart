import 'package:brewery/blocs/home/home_bloc.dart';
import 'package:brewery/screens/casks_screen.dart';
import 'package:brewery/screens/formulae_screen.dart';
import 'package:brewery/screens/settings_screen.dart';
import 'package:brewery/widgets/menu_button.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, int>(
      builder: (context, index) => Scaffold(
        appBar: AppBar(
          title: Text('Brewery'),
          actions: [
            PopupMenuButton(
              onSelected: (index) {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
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
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500.0,
              ),
              child: ListView(
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
                  RegexpFilter(
                    title: 'Search formulae or casks',
                    onChanged: (filter) {},
                    controller: _controller,
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
          ),
        ),
      ),
    );
  }
}
