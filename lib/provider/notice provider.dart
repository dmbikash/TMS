import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';



class NoticeProvider with ChangeNotifier{


  Future<List<dynamic>> getAllNotice() async {

    String? batchId = await getBatchIdFromLocalStorage();
    print("batchId-----------------------$batchId");

    String? token = getTokenFromLocalStorage();

    if (token != null) {
      print('token ase- $token');
      // Use the token for your API calls
    } else {
      print('The token is not available. Handle the user being logged out or not logged in');
    }

    String url = "http://localhost:8090/classroom/notice-board/$batchId";
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    print("response.statusCode----ALL Notice PAISI MAMA ${response.statusCode}");
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      data = data["notices"];
      int c = data.length-1;
      var temp = [];
      for(int i= c; i>=0; i--){
        temp.add(data[i]);
      }

      return temp;
    }
    return [];
  }

  String? getBatchIdFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['batchId'];
  }

  String? getTokenFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }


}