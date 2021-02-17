import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  void fetchData() async {
    var url = "https://formulae.brew.sh/api/formula/lazygit.json";
    var response = await http.get(url);
    var obj = jsonDecode(response.body);
    var fullName = obj["full_name"];
  }
}
