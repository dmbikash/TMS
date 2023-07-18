

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


  Future<void> createTrainee(var batchInfo) async {

    String? token = getTokenFromLocalstorage();
    String? url = 'http://localhost:8090/auth/register';
    //token = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbIkFETUlOIl0sInVzZXJJZCI6MSwic3ViIjoic3VwZXJhZG1pbkBnbWFpbC5jb20iLCJpYXQiOjE2ODk2MTIzNDMsImV4cCI6MTY4OTY5ODc0M30.iTH8AtkBev5RDO-Bwi2TPKHdz-Wk0r0POE-MkE6sk70";
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
    request.fields['fullName'] = "bandir put";//
    request.fields['contactNumber'] = "01fuck-cuck";//
    request.fields['email'] = "nya.com";//
    request.fields['role'] = "TRAINER";//
    request.fields['password'] = "6969";//
    request.fields['designation'] = "6969";//
    request.fields['joiningDate'] = "6969";//
    request.fields['yearsOfExperience'] = "6969";//
    request.fields['expertises'] = "6969";//
    request.fields['presentAddress'] = "6969";//




    // Add trainers field if needed
    // request.fields['trainers'] = jsonEncode(batchInfo['trainers']);

    // Add image file if needed
    // String imagePath = "PATH_TO_YOUR_IMAGE_FILE";
    // String fileName = imagePath.split('/').last;
    // request.files.add(await http.MultipartFile.fromPath('image', imagePath, filename: fileName));

    // Send the request and await the response.
    var response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseString);
      print(jsonResponse);
      print('trainer Data posted successfully');
      //Navigator.pop(context);
    } else {
      print('Error occurred while posting Trainer data: ${response.statusCode}');
    }
  }

  Future<void> createTrainer(var batchInfo) async {

    String? token = getTokenFromLocalstorage();
    String? url = 'http://localhost:8090/auth/register';
    //token = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbIkFETUlOIl0sInVzZXJJZCI6MSwic3ViIjoic3VwZXJhZG1pbkBnbWFpbC5jb20iLCJpYXQiOjE2ODk2MTIzNDMsImV4cCI6MTY4OTY5ODc0M30.iTH8AtkBev5RDO-Bwi2TPKHdz-Wk0r0POE-MkE6sk70";
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
    request.fields['fullName'] = "bandir put";//
    request.fields['contactNumber'] = "01fuck-cuck";//
    request.fields['email'] = "nya.com";//
    request.fields['gender'] = "magi";//
    request.fields['role'] = "TRAINEE";//
    request.fields['password'] = "6969";//
    request.fields['dateOfBirth'] = "1990-01-01";//
    request.fields['educationalInstitute'] = "6969";//
    request.fields['DegreeName'] = "6969";//
    request.fields['cgpa'] = ".5";//
    request.fields['DegreeName'] = "19705";
    request.fields['presentAddress'] = "19705";

    // Add trainers field if needed
    // request.fields['trainers'] = jsonEncode(batchInfo['trainers']);

    // Add image file if needed
    // String imagePath = "PATH_TO_YOUR_IMAGE_FILE";
    // String fileName = imagePath.split('/').last;
    // request.files.add(await http.MultipartFile.fromPath('image', imagePath, filename: fileName));

    // Send the request and await the response.
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