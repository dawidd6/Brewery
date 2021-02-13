import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Brewery",
      theme: ThemeData(
        primarySwatch: MyColors.brownMaterial,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: MyColors.brown,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  final title = "Brewery";

  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  void fetchData() async {
    var url = "https://formulae.brew.sh/api/formula/lazygit.json";
    var response = await http.get(url);
    var obj = convert.jsonDecode(response.body);
    var fullName = obj["full_name"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}

class MyColors {
  static final Color brown = Color(0xFF2F2A25);
  static final MaterialColor brownMaterial = MaterialColor(
    brown.value,
    <int, Color>{
      50: brown,
      100: brown,
      200: brown,
      300: brown,
      400: brown,
      500: brown,
      600: brown,
      700: brown,
      800: brown,
      900: brown,
    },
  );
}
