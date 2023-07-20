import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:universal_html/html.dart" as html;
import 'package:http/http.dart' as http;


class BatchDetailsProvider with ChangeNotifier {

  Future<dynamic> getBatchByBatchId() async {

    String? token = getTokenFromLocalStorage();
    int tempBatchId =  int.parse(getBatchIdInLocalStorage()!);

    String url = "http://localhost:8090/batch/$tempBatchId";

    print("1");
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data;
    }
    return [];
  }



  String? getBatchIdInLocalStorage() {
    final storage = html.window.localStorage;
    return storage['batchId'];
  }

  String? getTokenFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }

}