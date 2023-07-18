import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginProvider with ChangeNotifier {
  String role = "xx";

  Future<void> get_role(String email, String password) async {
    const url1 = "http://localhost:8090/auth/login";
    final url = Uri.parse(url1);
    final headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    final body = json.encode({"email": email, "password": password});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('login request successful');
        // print('Response body: ${response.body}');
        var responseBody = jsonDecode(response.body);
        String token = responseBody["token"];
        print("token--$token");
        saveTokenToLocalstorage(token);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        if (decodedToken != null) {
          print(decodedToken['role'][0]);
          role = decodedToken['role'][0];
          // You can access token details using decodedToken['your_key']
          // For example: decodedToken['sub'] for the subject, decodedToken['exp'] for the expiration time, etc.
        } else {
          print("Invalid token.");
        }
        //return decodedToken['role'][0];
      } else {
        print('Failed to create post. Error code: ${response.statusCode}');
        //return "";
      }
    } catch (e) {
      print('Error sending POST request: $e');
    }
    //return "";

    notifyListeners();
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
