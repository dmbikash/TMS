import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:universal_html/html.dart" as html;

class AdminDashboardProvider with ChangeNotifier{

  Future<List<dynamic>>get_batch() async {

    String? token = getTokenFromLocalstorage();
    //print(token);
    if (token != null) {
      print('token ase- $token');
      // Use the token for your API calls
    } else {
      print('The token is not available. Handle the user being logged out or not logged in');
    }
    print("ami call hochhi");
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? token = await prefs.getString('token');
    //print("ami call hochhi na $token2");

    //token2 = token!;

    const String url = "http://localhost:8090/batch";
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data;
    }
    return [];
  }

  void saveTokenToLocalstorage(String token) {
    final storage = html.window.localStorage;
    storage['token'] = token;
  }

  String? getTokenFromLocalstorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }



}