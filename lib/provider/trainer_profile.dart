import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class TrainerProfileProvider with ChangeNotifier{



  Future<dynamic> getUserInfobyUserId() async {
    String? userID = await getUserIdFromLocalStorage();

    String? token = getTokenFromLocalStorage();
    //print(token);
    if (token != null) {
      print('token ase- $token');
      // Use the token for your API calls
    } else {
      print('The token is not available. Handle the user being logged out or not logged in');
    }


    String url = "http://localhost:8090/trainer/user/$userID";
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    print("response.statusCode----getUserInfobyUserId ${response.statusCode}");
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);

      return data;
    }
    return [];
  }
  String? getTokenFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }


  String? getUserIdFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['userId'];

  }
}