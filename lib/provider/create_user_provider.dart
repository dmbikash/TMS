

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;
class CreateUserProvider with ChangeNotifier{


  ///ui part-------------

  bool adminFlag = true;
  bool traineeFlag = false;
  bool trainerFlag = false;

  void clickOnSideMenu(int c){
     adminFlag = false;
     traineeFlag = false;
     trainerFlag = false;
     if(c==1) adminFlag =true;
     if(c==2) traineeFlag =true;
     if(c==3) trainerFlag =true;
     notifyListeners();

  }






  // ------------------------------------functionalities

  String _imageName = "";
  var image = null;

  Future<void> createAdmin(var adminData) async {
    print(adminData);

    String? token = getTokenFromLocalstorage();
    String? url = 'http://localhost:8090/auth/register';

    final headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    if (image!= null) {
      Uint8List data = await image.readAsBytes();
      List<int> list = data.cast();
      final imageFile = await http.MultipartFile.fromBytes('profilePictureMultipartFile', list, filename: _imageName);
      print(imageFile);
      request.files.add(imageFile);
    }
    request.fields['fullName'] = adminData['name'];
    request.fields['contactNumber'] = adminData['contact'];
    request.fields['email'] = adminData['email'];
    request.fields['gender'] = adminData['gender'];
    request.fields['role'] = adminData['role'];
    request.fields['password'] = adminData['password'];


    var response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseString);
      print(jsonResponse);
      print('Admin Created successfully');
      //Navigator.pop(context);
    } else {
      print('Error occurred while posting ADmin data: ${response.statusCode}');
    }
  }

  Future<void> createTrainee(var traineeData) async {

    String? token = getTokenFromLocalstorage();
    String? url = 'http://localhost:8090/auth/register';

    final headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    if (image!= null) {
      Uint8List data = await image.readAsBytes();
      List<int> list = data.cast();
      final imageFile = await http.MultipartFile.fromBytes('profilePictureMultipartFile', list, filename: _imageName);
      print(imageFile);
      request.files.add(imageFile);
    }
    request.fields['fullName'] = traineeData["name"];
    request.fields['contactNumber'] = traineeData["contact"];
    request.fields['email'] = traineeData["email"];
    request.fields['role'] = "TRAINEE";
    request.fields['password'] = traineeData["password"];
    request.fields['dateOfBirth'] = traineeData["dateOfBirth"];
    request.fields['cgpa'] = traineeData["cgpa"];
    request.fields['educationalInstitute'] = traineeData["educationalInstitute"];
    request.fields['gender'] = traineeData["gender"];
    request.fields['passingYear'] = traineeData["passingYear"];
    request.fields['degreeName'] = traineeData["degreeName"];
    request.fields['presentAddress'] = traineeData["presentAddress"];

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseString);
      print(jsonResponse);
      print('trainee Data posted successfully');
      //Navigator.pop(context);
    } else {
      print('Error occurred while posting Trainee data: ${response.statusCode}');
    }
  }

  Future<void> createTrainer(var trainerData) async {

    String? token = getTokenFromLocalstorage();
    String? url = 'http://localhost:8090/auth/register';

    final headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    if (image!= null) {
      Uint8List data = await image.readAsBytes();
      List<int> list = data.cast();
      final imageFile = await http.MultipartFile.fromBytes('profilePictureMultipartFile', list, filename: _imageName);
      print(imageFile);
      request.files.add(imageFile);
    }

    request.fields['fullName'] = trainerData["name"];
    request.fields['email'] = trainerData["email"];
    request.fields['password'] = trainerData["password"];
    request.fields['role'] = "TRAINER";
    request.fields['designation'] = trainerData["designation"];
    request.fields['joiningDate'] = trainerData["joiningDate"];
    request.fields['yearsOfExperience'] = trainerData["yearsOfExperience"];
    request.fields['expertises'] = trainerData["expertises"];
    request.fields['contactNumber'] = trainerData["contact"];
    request.fields['presentAddress'] = trainerData["presentAddress"];

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseString);
      print(jsonResponse);
      print('Data posted successfully');
      //Navigator.pop(context);
    } else {
      print('Error occurred while posting data: ${response.statusCode}');
    }
  }

  String? getTokenFromLocalstorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }


  Future<void> pickImage(BuildContext context) async {
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        SnackBar(
          content: Text("NULL FILE"),
        );
      }else{
        _imageName = image.name;
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }


}