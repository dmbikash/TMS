import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;
import 'package:file_picker/file_picker.dart';




class AssignmentTrainerProvider with ChangeNotifier {

  var assignmentFileName = "";
  var assignment ;

  String trainerId = 'kfhf-2';
  String batchId = 'sfsdf-2';



  Future<void> createAssignment(var adminData, BuildContext context) async {
    print("create assignment");
    print(adminData);
    print(assignmentFileName);


    String? token = getTokenFromLocalStorage();
    String? url = 'http://localhost:8090/assignment/create';

    final headers = {
      'Authorization': 'Bearer $token',
    };
    print(token);


    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    print(assignmentFileName);
    try{
      //print(assignment);
     // print(assignmentFileName);
      if (assignment != null) {
        //Uint8List data = await assignment!.readAsBytes();
       // List<int> list = data.cast();
        final assignmentFile = await http.MultipartFile.fromBytes(
            'assignmentMultipartFile', assignment,
            filename: assignmentFileName);
        request.files.add(assignmentFile);
      } else {
        print("image e jhamela");
      }
    }catch(e){
      print("ekhane jhamela $e");
    }

    trainerId =  getTrainerIdFromLocalStorage()!;

    batchId =  getBatchIdInLocalStorage()!;

   //  print("trainerId--------khalid----------$trainerId");
   // print('batchId-------------khalid----------------$batchId');

    request.fields['title'] = adminData['title'];
    request.fields['description'] = adminData['description'];
    request.fields['deadline'] = adminData['deadline'];
    request.fields['trainerId'] = trainerId;        //['trainerId'];
    request.fields['batchId'] = batchId;         //['batchId'];

    var response = await request.send();

    if (response.statusCode == 200) {

      String responseString = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseString);
      print('Assignment Created successfully');
      notifyListeners();
      Navigator.pop(context);
    }else{
      print(response.statusCode);
    }
  }

  Future<void> pickFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles();
     assignment =  result!.files.first.bytes;


      if (assignment == null) {
        SnackBar(
          content: Text("NULL FILE"),
        );
      }else{
        assignmentFileName =  result.files.first.name;
      }
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<List<dynamic>> getAssignmentsByBatchId() async {

    String? token = getTokenFromLocalStorage();


    //int tempBatchId =  int.parse(getBatchIdInLocalStorage()!);

    //trainerId =  (getTrainerIdFromLocalStorage()!);

    batchId =  getBatchIdInLocalStorage()!;
   //print("trainerId------------------$trainerId");
    //print('batchId-----------------------------$batchId');

    String url = "http://localhost:8090/assignment/batch/$batchId";

    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
      print(data);
    }
    return [];
  }

  String? getTokenFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }

  String? getBatchIdInLocalStorage() {
    final storage = html.window.localStorage;
    return storage['batchId'];
  }



  String? getTrainerIdFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['trainerId'];

  }
}


