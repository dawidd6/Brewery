import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MyColors.brownMaterial,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  var title = "Brewery";

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
    setState(() {
      widget.title = fullName;
    });
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
  static const int brown = 0xFF2F2A25;
  static const MaterialColor brownMaterial = MaterialColor(
    brown,
    <int, Color>{
      50: Color(brown),
      100: Color(brown),
      200: Color(brown),
      300: Color(brown),
      400: Color(brown),
      500: Color(brown),
      600: Color(brown),
      700: Color(brown),
      800: Color(brown),
      900: Color(brown),
    },
  );
}
