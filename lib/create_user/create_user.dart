
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:training_management_system/components/my_app_bar.dart';
import 'package:training_management_system/provider/create_user_provider.dart';

import '../components/box_decorations.dart';
import '../components/color.dart';
import '../components/screen_size.dart';
import '../components/text_style.dart';



class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {


  File? _pickedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Create User',),
      body: Consumer<CreateUserProvider>(
        builder:(context, createUserProvider, child){
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: width(context),
                  //height: height(context) * .90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 38.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 50),
                            height: height(context) * .80,
                            decoration: box12Sidebar,
                            //color: Colors.orangeAccent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      //decoration: box12Sidebar,
                                      child: TextLiquidFill(
                                        text: 'Profile',
                                        waveColor: sweetYellow,
                                        boxBackgroundColor: Colors.black,
                                        textStyle: black20,
                                        boxHeight: 70,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      //decoration: box12Sidebar,
                                      child: TextLiquidFill(
                                        text: 'BATCH',
                                        waveColor: sweetYellow,
                                        boxBackgroundColor: Colors.black,
                                        textStyle: black20,
                                        boxHeight: 70,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, "CreateUser");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: TextLiquidFill(
                                        text: 'CREATE ACCOUNT',
                                        waveColor: sweetYellow,
                                        boxBackgroundColor: Colors.black,
                                        textStyle: black20,
                                        boxHeight: 70,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: TextLiquidFill(
                                        text: 'Logout',
                                        waveColor: sweetYellow,
                                        boxBackgroundColor: Colors.black,
                                        textStyle: black20,
                                        boxHeight: 70,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      //body
                      /// --------------------------------------------------------------------
                      ///
                      ///
                      /// --------------------------------------------------------------------
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 100),
                          child: Column(
                            children: [

                              Row(
                                children: [
                                  Expanded(
                                    flex:3,
                                    child: Container(
                                      //color: Colors.red,
                                      width: width(context)*.5,
                                      height: height(context)*.1,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: "name"
                                        ),
                                      ),

                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    flex: 1,
                                      child: ElevatedButton(
                                        onPressed: () {  },
                                        child: Text("Image Uplaod"),

                                      ),),
                                ],
                              ),
                              Container(
                                //color: Colors.red,
                                width: width(context)*.5,
                                height: height(context)*.1,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Email"
                                  ),
                                ),

                              ),
                              Container(
                                //color: Colors.red,
                                width: width(context)*.5,
                                height: height(context)*.1,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "PassWord"
                                  ),
                                ),

                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: Container(
                                      //color: Colors.red,
                                      height: height(context)*.1,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: "Contact"
                                        ),
                                      ),

                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      //color: Colors.red,
                                      height: height(context)*.1,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: "Gender"
                                        ),
                                      ),

                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    //onPressed: () => _pickImage(ImageSource.camera),
                                    onPressed: () {  },
                                    child: Text("HONK ME")),
                              )

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(top: 50,right: 38),
                           height: height(context) * .80,
                           //color: Colors.purple,
                          decoration: box12Sidebar,
                          child: Center(
                            child: CircleAvatar(
                              minRadius: 40,
                              child: Image.network("https://www.freeiconspng.com/thumbs/computer-user-icon/computer-user-icon-28.png") ,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
