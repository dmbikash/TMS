import 'dart:convert';

import "package:universal_html/html.dart" as html;
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class CourseInfoTrainerProvider with ChangeNotifier {

  Future<List<dynamic>> getCoursesByBatchId() async {

    String? token = getTokenFromLocalStorage();
    int tempBatchId =  int.parse(getBatchIdInLocalStorage()!);

    String url = "http://localhost:8090/course/batch/$tempBatchId";

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




  String? getBatchIdInLocalStorage() {
    final storage = html.window.localStorage;
    return storage['batchId'];
  }

  String? getTokenFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }

}

