import 'dart:convert';
import 'dart:html';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';


class ClassRoomProvider with ChangeNotifier {


 /// --------------------------------------------------get   post in class room
 Future<List<dynamic>> getAllPosts() async {

  String? batchId = await getBatchIdFromLocalStorage();
  print("batchId-----------------------$batchId");

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

  String url = "http://localhost:8090/classroom/post-list/$batchId";
  final response = await http.get(
   Uri.parse(url),
   headers: {"Authorization": "Bearer $token"},
  );

  print("response.statusCode----ALL POST PAISI MAMA ${response.statusCode}");
  print(response.body);
  if (response.statusCode == 200) {
   var data = jsonDecode(response.body);
   print(data);
   int c = data.length-1;
   var temp = [];
   for(int i= c; i>=0; i--){
    temp.add(data[i]);
   }

   return temp;
  }
  return [];
 }

  Future<List<dynamic>> classRoomPost() async{






   var a =   [
    {
     "postId": 1,
     "textData": "AMANR BUKE ONK KOSTO",
     "filePath": "/path/to/file",
     "postDate": "2023-07-12T10:30:00",
     "comments": [
      {
       "commentId": 1,
       "commentData": "khane comment korse",
       "commentTime": "2023-07-12T01:19:18Z",
       "name": "khan",
       "postId": 1,
       "userId": 5
      },
      {
       "commentId": 2,
       "commentData": "khane comment korse",
       "commentTime": "2023-07-12T01:19:18Z",
       "name": "tazkir",
       "postId": 1,
       "userId": 4
      },
      {
       "commentId": 3,
       "commentData": "tazkir comment korse",
       "commentTime": "2023-07-12T01:19:18Z",
       "name": "tazkir",
       "postId": 1,
       "userId": 4
      }
     ],
     "trainerName": "khan",
     "trainerId": 1,
     "classroomId": 1
    },
    {
     "postId": 1,
     "textData": "khal;id er  BUKE ONK KOSTO",
     "filePath": "/path/to/file",
     "postDate": "2023-07-12T10:30:00",
     "comments": [
      {
       "commentId": 1,
       "commentData": "sadlife insurance and policy",
       "commentTime": "2023-07-12T01:19:18Z",
       "name": "rafid",
       "postId": 1,
       "userId": 5
      },
      {
       "commentId": 2,
       "commentData": "ami gay",
       "commentTime": "2023-07-12T01:19:18Z",
       "name": "tazkir",
       "postId": 1,
       "userId": 4
      },
      {
       "commentId": 3,
       "commentData": "gu khabi",
       "commentTime": "2023-07-12T01:19:18Z",
       "name": "tazkir",
       "postId": 1,
       "userId": 4
      }
     ],
     "trainerName": "khan",
     "trainerId": 1,
     "classroomId": 1
    }
   ];

   int c = a.length-1;
   var temp = [];
   for(int i= c; i>=0; i--){
      temp.add(a[i]);
   }
    return temp;
  }

/// --------------------------------------------------create post / file in class room

 var assignmentFileName = "";
 var assignment ;


 Future<void> createPost(var postData, BuildContext context) async {
 // print("create assignment");
 // print(postData);
//  print(assignmentFileName);

  String? batchId = getBatchIdFromLocalStorage();


  String? token = getTokenFromLocalStorage();
  String? url = 'http://localhost:8090/classroom/post';

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
        'postFile', assignment,
        filename: assignmentFileName);
    request.files.add(assignmentFile);
   } else {
    print("image e jhamela");
   }
  }catch(e){
   print("ekhane jhamela $e");
  }

  String? trainerId =  getTrainerIdFromLocalStorage()!;

  batchId =  getBatchIdInLocalStorage()!;

  //  print("trainerId--------khalid----------$trainerId");
  // print('batchId-------------khalid----------------$batchId');

  request.fields['textData'] = postData['textData'];
  request.fields['postDate'] = postData['postDate'];
  request.fields['trainerId'] = trainerId;        //['trainerId'];
  request.fields['classroomId'] = batchId;         //['batchId'];

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

  String? getBatchIdFromLocalStorage() {
   final storage = html.window.localStorage;
   return storage['batchId'];
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

 void downloadFile(String fileUrl) {
  // Create a new anchor element
  AnchorElement anchor = AnchorElement(href: fileUrl)
   ..target = '_blank' // Open the link in a new tab/window
   ..download = ''; // Set the 'download' attribute to force download

  // Programmatically click the anchor element
  anchor.click();
 }

 /// ----------------------------------create class room comment


 Future<void> createComment(var commentData, BuildContext context) async {

  print("commentData-------------$commentData");

  String? token = getTokenFromLocalStorage();
  String? url = 'http://localhost:8090/classroom/comment';

  final headers = {
   'Content-Type': 'application/json',
   'Authorization': 'Bearer $token',
  };


  int userId = int.parse(getUserIdFromLocalStorage()!);

  final data = {
   "commentData": commentData["commentData"],
   "commentTime": DateTime.now().toString(),
   "postId": commentData["postId"],
   "userId": userId,

  };
  final jsonBody = jsonEncode(data);
  final response =
  await http.post(Uri.parse(url), headers: headers, body: jsonBody);

  if (response.statusCode == 200) {
   print(response.body);
   print('Data posted successfully');

  } else {
   // Error occurred while posting data
   print('Error occurred while posting data: ${response.body}');
  }
  notifyListeners();
 }

 String? getUserIdFromLocalStorage() {
  final storage = html.window.localStorage;
  return storage['userId'];
 }




}