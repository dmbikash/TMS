import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:training_management_system/components/text_style.dart';
import 'package:image_picker/image_picker.dart';


class AdminRegister extends StatefulWidget {
  const AdminRegister({Key? key}) : super(key: key);

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  String _imageName = "";
  var image;

  File? _pickedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: ()  {
                  _pickImage();
                },
                child: Text("pick",style: black40,)),
            ElevatedButton(
                onPressed: ()  {
                  createAdmin("batchInfo");
                },
                child: Text("uplload",style: black40,)),
          ],
        ),
      ),
    );
  }
  Future<void> createAdmin(var batchInfo) async {

    String? token = getTokenFromLocalstorage();
    String? url = 'http://localhost:8090/auth/register';
    token = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbIkFETUlOIl0sInVzZXJJZCI6MSwic3ViIjoic3VwZXJhZG1pbkBnbWFpbC5jb20iLCJpYXQiOjE2ODk2MTIzNDMsImV4cCI6MTY4OTY5ODc0M30.iTH8AtkBev5RDO-Bwi2TPKHdz-Wk0r0POE-MkE6sk70";
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
    request.fields['fullName'] = "bandir put";
    request.fields['contactNumber'] = "01fuck-cuck";
    request.fields['email'] = "nyyyy@torgoya.com";
    request.fields['gender'] = "magi";
    request.fields['role'] = "ADMIN";
    request.fields['password'] = "6969";

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

  Future<void> _pickImage() async {
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        SnackBar(
          content: Text("NULL FILE"),
        );
      }else{
        _imageName = image.name;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

}
