import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:training_management_system/components/box_decorations.dart';
import 'package:training_management_system/components/screen_size.dart';
import 'package:training_management_system/provider/classroom_provider.dart';

import '../components/color.dart';

class ClassRoomPage extends StatefulWidget {
  const ClassRoomPage({Key? key}) : super(key: key);

  @override
  State<ClassRoomPage> createState() => _ClassRoomPageState();
}

class _ClassRoomPageState extends State<ClassRoomPage> {

  final commentData = TextEditingController();
  int a = 5;

  final _classRoomPostFormKey = GlobalKey<FormState>();
  final textData = TextEditingController();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void dispose() {
    print("tata bye bye a er value komay disi");
    print(a);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClassRoomProvider>(
      builder: (context, classRoomProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
           // color: Colors.green,
            height: height(context),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       a=a+1;
                  //     });
                  //   },
                  //   child: Text("press $a"),
                  //
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ClassRoom",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        QuickAlert.show(
                            onConfirmBtnTap: () {
                              if (_classRoomPostFormKey.currentState!
                                  .validate()) {
                                print(textData.text);
                                classRoomProvider
                                    .createPost({
                                  'textData': textData.text,
                                  'postDate': formattedDate,
                                }, context);
                              }
                            },
                            context: context,
                            type: QuickAlertType.info,
                            confirmBtnColor: sweetYellow,
                            confirmBtnText: "Create",
                            title: "Create Assignment",

                            widget: Form(
                              key: _classRoomPostFormKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty)
                                        return "Required";
                                    },
                                    controller: textData,
                                    decoration: InputDecoration(
                                        hintText: "Write Something Here..."),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 500,
                                    child: Row(
                                      children: [

                                        const SizedBox(
                                          width: 100,
                                        ),

                                        Expanded(
                                          flex: 1,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              classRoomProvider.pickFile(context);
                                            },
                                            child: classRoomProvider
                                                .assignment == null
                                                ? Text("Select File")
                                                : Icon(
                                              Icons.check_box_rounded,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // TextFormField(),
                                  //TextFormField(),
                                ],
                              ),
                            ));
                      },
                      child: Text("Create Post"),
                    ),
                  ),
                  Container(
                    height: height(context) * .9,
                    //color: Colors.lime,
                    child: FutureBuilder<List<dynamic>>(
                      future: classRoomProvider.getAllPosts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List? allPosts = snapshot!.data;
                          return ListView.builder(
                            itemCount: allPosts!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: boxNoBorder,
                                  width: width(context) * .4,
                                  height: height(context) * .45,
                                  //color: Colors.teal[800],
                                  child: Row(
                                    children: [
                                      /////////////////////// bam diker kolam
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [ Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Text(
                                              allPosts[index]["trainerName"],
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 30,
                                              ),
                                            ),
                                          ),


                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                allPosts[index]["textData"],
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            SizedBox(
                                              height: height(context)*.25,
                                            ),
                                            if(allPosts[index]["filePath"] != null )Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text("Attatchments",style: TextStyle(fontWeight: FontWeight.w600),),
                                                  SizedBox(width: 10,),
                                                  IconButton(
                                                    onPressed: (){
                                                      classRoomProvider.downloadFile("http://localhost:8090/classroom/download/${allPosts[index]["postId"]}");
                                                    },
                                                      icon:Icon(Icons.attachment)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ///////////////////////////////// dan diker kolam
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                print("tap-$a");
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          content:
                                                              SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              ////////////////////////          commewnts here
                                                              height: height(
                                                                      context) *
                                                                  .7,
                                                              width: width(
                                                                      context) *
                                                                  .5,
                                                              color: Colors
                                                                  .deepPurple,
                                                              child: ListView
                                                                  .builder(
                                                                      itemCount:
                                                                          allPosts[index]["comments"]
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              commentIndex) {
                                                                        var comment =
                                                                            allPosts[index]["comments"][commentIndex];
                                                                        return Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  Icon(Icons.supervised_user_circle),
                                                                                  Text(comment["name"]),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(comment["commentData"]),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Divider(),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      }),
                                                            ),
                                                            Container(
                                                              ////////////////////////          commewnt's intuput here
                                                              height: height(
                                                                      context) *
                                                                  .09,
                                                              color: Colors
                                                                  .white60,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextFormField(
                                                                      controller: commentData,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          suffix:
                                                                              TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              if(commentData.text != ""){
                                                                                var commentDataMap = {
                                                                                  "commentData": commentData.text,
                                                                                  "postId": allPosts[index]["postId"],
                                                                                };
                                                                                classRoomProvider.createComment(commentDataMap, context);
                                                                                commentData.text= "";
                                                                                Navigator.pop(context);
                                                                              }
                                                                                },
                                                                            child:
                                                                                Text("POST"),
                                                                          ),
                                                                          hintText:
                                                                              "Type Your Comment Here...",
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(20)),
                                                                          )),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ));
                                                    });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  ////////////////////////          commewnts here
                                                  height: height(context) * .30,
                                                  width: width(context),
                                                  //color: Colors.deepPurple,
                                                  decoration: boxNoBorder2,
                                                  child: ListView.builder(
                                                      itemCount: allPosts[index]
                                                              ["comments"]
                                                          .length,
                                                      itemBuilder: (context,
                                                          commentIndex) {
                                                        var comment =
                                                            allPosts[index]
                                                                    ["comments"]
                                                                [commentIndex];
                                                        return Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Icon(Icons
                                                                      .supervised_user_circle),
                                                                  Text(comment["name"] ,
                                                                  style: TextStyle(fontWeight: FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(comment[
                                                                  "commentData"],
                                                              style: TextStyle(color: Colors.black54),),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Divider(),
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              ////////////////////////          commewnt's intuput here
                                              height: height(context) * .09,
                                             // color: Colors.white60,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  controller: commentData,
                                                  decoration: InputDecoration(

                                                    fillColor: Colors.deepPurple,
                                                      hoverColor: Colors.green,
                                                      focusColor: Colors.blueAccent,
                                                      suffix: TextButton(
                                                        onPressed: () {
                                                          if(commentData.text != ""){
                                                            var commentDataMap = {
                                                              "commentData": commentData.text,
                                                              "postId": allPosts[index]["postId"],
                                                            };
                                                            classRoomProvider.createComment(commentDataMap, context);
                                                            commentData.text= "";
                                                          }
                                                        },
                                                        child: Text("POST"),
                                                      ),
                                                      hintText:
                                                          "Type Your Comment Here...",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        if (snapshot.hasError) {
                          return Text("snpashot e error ${snapshot.error}");
                        }
                        return Text("SOMETHIng WENT GOLMAL");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
