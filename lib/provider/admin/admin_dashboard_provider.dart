import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:universal_html/html.dart" as html;

class AdminDashboardProvider with ChangeNotifier {

  Future<List<dynamic>> getBatch() async {
    String? token = getTokenFromLocalStorage();

    const String url = "http://localhost:8090/batch";
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
    return [];
  }

  Future<List<dynamic>> getBatchById(int batchId) async {
    String? token = getTokenFromLocalStorage();

    String url = "http://localhost:8090/batch/$batchId";
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
    return [];
  }

  Future<void> postBatch(var batchInfo, BuildContext context) async {
    String? token = html.window.localStorage['token'];
    String? url = 'http://localhost:8090/batch/create';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final data = {
      "batchName": batchInfo['name'],
      "startDate": batchInfo['start_date'],
      "endDate": batchInfo['end_date'],
      "trainers": null,

    };
    final jsonBody = jsonEncode(data);
    final response =
    await http.post(Uri.parse(url), headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      notifyListeners();
      Navigator.pop(context);
    }


  }

  String? getTokenFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }

}