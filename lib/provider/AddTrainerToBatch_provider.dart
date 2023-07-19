import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import "package:universal_html/html.dart" as html;
import 'package:http/http.dart' as http;

class AddTrainerToBatchProvider with ChangeNotifier{
  /// ---------------------------------------------------------------trainer part

  List<int> selectedTrainers = [];

  void addToSelectedTrainers(int c){
    selectedTrainers.add(c);
    notifyListeners();
  }

  bool isSelected(int c){
    return selectedTrainers.contains(c);
  }



  Future<List<dynamic>> getTrainers() async {

    String? token = getTokenFromLocalStorage();
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

    const String url = "http://localhost:8090/trainer";
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Trainers data  --- $data");
      return data;
    }
    return [];
  }

  String? getTokenFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }

  Future<void> postTrainerToBatch(var batchInfo) async {
    //List categoryDataList, BuildContext context;
    //print(categoryDataList[0]);

    String? token = getTokenFromLocalStorage();
    String? url = 'http://localhost:8090/batch/trainer-assign';
    //print(url!+token!);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final data = {
      "trainerId": batchInfo['trainerId'],
      "batchId": batchInfo['batchId'],


    };
    final jsonBody = jsonEncode(data);
    final response =
    await http.post(Uri.parse(url), headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      print(response.body);
      // Data posted successfully
      print('Data posted successfully');
    } else {
      // Error occurred while posting data
      print('Error occurred while posting data: ${response.body}');
    }
  }




/// ---------------------------------------------------------------trainee part
///
///
///
///
///

}