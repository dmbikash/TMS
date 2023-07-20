
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:training_management_system/components/my_app_bar.dart';
import 'package:training_management_system/provider/admin/create_user_provider.dart';

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
  final userCreateFormKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final contact =TextEditingController();
  final gender = TextEditingController();
  final designation = TextEditingController();
  final joiningDate = TextEditingController();
  final yearsOfExperience = TextEditingController();
  final expertises = TextEditingController();
  final dateOfBirth = TextEditingController();
  final degreeName = TextEditingController();
  final educationalInstitute = TextEditingController();
  final cgpa = TextEditingController();
  final passingYear = TextEditingController();
  final presentAddress = TextEditingController();


  File? _pickedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Create User',),
      body: Consumer<CreateUserProvider>(
        builder:(context, createUserProvider, child){
          return SingleChildScrollView(
            child: Form(
              key: userCreateFormKey,
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
                                    onTap: (){
                                      createUserProvider.clickOnSideMenu(1);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        //decoration: box12Sidebar,
                                        child: TextLiquidFill(
                                          text: 'CREATE ADMIN',
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
                                      createUserProvider.clickOnSideMenu(2);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        //decoration: box12Sidebar,
                                        child: TextLiquidFill(
                                          text: 'CREATE TRAINEE',
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
                                      createUserProvider.clickOnSideMenu(3);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: TextLiquidFill(
                                          text: 'CREATE TRAINER',
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
                        ///                     ----------BODY--------
                        ///
                        /// --------------------------------------------------------------------
                        if(createUserProvider.adminFlag) Expanded(
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
                                          controller: name,
                                          validator: (val){if(val!.isEmpty) return "required field";},
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
                                          onPressed: () { createUserProvider.pickImage(context); },
                                          child: createUserProvider.image == null? Text("Select Image") : Icon(Icons.thumb_up_sharp,color: Colors.green,),

                                        ),),
                                  ],
                                ),
                                Container(
                                  //color: Colors.red,
                                  width: width(context)*.5,
                                  height: height(context)*.1,
                                  child: TextFormField(
                                    controller: email,
                                    validator: (val){if(val!.isEmpty) return "required field";},

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
                                    controller: password,
                                    validator: (val){if(val!.isEmpty) return "required field";},

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
                                          controller: contact,
                                          validator: (val){if(val!.isEmpty) return "required field";},

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
                                          controller: gender,
                                          validator: (val){if(val!.isEmpty) return "required field";},

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
                                      onPressed: () {
                                        if(userCreateFormKey.currentState!.validate()){
                                          print("yeeee all ok---image diso to?");

                                          var adminData = {
                                            "name" : name.text,
                                            "email" : email.text,
                                            "password" : password.text,
                                            "contact" : contact.text,
                                            "gender" : gender.text,
                                            "role" : "ADMIN",
                                          };
                                          createUserProvider.createAdmin(adminData);
                                        }
                                      },
                                      child: Text("Register")),
                                )

                              ],
                            ),
                          ),
                        ),
                        if (createUserProvider.traineeFlag) Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 100),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          width: width(context) * .5,
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: name,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Name",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            createUserProvider.pickImage(context);
                                          },
                                          child: createUserProvider.image == null
                                              ? Text("Select Image")
                                              : Icon(
                                            Icons.thumb_up_sharp,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: email,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Email",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: password,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Password",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: contact,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Contact Number",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: gender,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Gender",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: dateOfBirth,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Date of Birth",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: cgpa,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "CGPA",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: educationalInstitute,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Educational Institute",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: passingYear,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Passing Year",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: degreeName,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Degree Name",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: presentAddress,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Present Address",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (userCreateFormKey.currentState!.validate()) {
                                          print("yeeee all ok---image diso to?");

                                          var traineeData = {
                                            "name": name.text,
                                            "email": email.text,
                                            "password": password.text,
                                            "dateOfBirth": dateOfBirth.text,
                                            "contact": contact.text,
                                            "cgpa": cgpa.text,
                                            "educationalInstitute": educationalInstitute.text,
                                            "gender": gender.text,
                                            "passingYear": passingYear.text,
                                            "presentAddress": presentAddress.text,
                                            "degreeName": degreeName.text,
                                            "role": "TRAINEE",
                                          };
                                          createUserProvider.createTrainee(traineeData);
                                        }
                                      },
                                      child: Text("HONK ME"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (createUserProvider.trainerFlag) Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 100),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          width: width(context) * .5,
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: name,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Name",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            createUserProvider.pickImage(context);
                                          },
                                          child: createUserProvider.image == null
                                              ? Text("Select Image")
                                              : Icon(
                                            Icons.thumb_up_sharp,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: width(context) * .5,
                                    height: height(context) * .1,
                                    child: TextFormField(
                                      controller: email,
                                      validator: (val) {
                                        if (val!.isEmpty) return "required field";
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width(context) * .5,
                                    height: height(context) * .1,
                                    child: TextFormField(
                                      controller: password,
                                      validator: (val) {
                                        if (val!.isEmpty) return "required field";
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: contact,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Contact Number",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: gender,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Gender",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: designation,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Designation",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: joiningDate,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Joining Date",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: yearsOfExperience,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Years of Experience",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: height(context) * .1,
                                          child: TextFormField(
                                            controller: expertises,
                                            validator: (val) {
                                              if (val!.isEmpty) return "required field";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Expertises",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: width(context) * .5,
                                    height: height(context) * .1,
                                    child: TextFormField(
                                      controller: presentAddress,
                                      validator: (val) {
                                        if (val!.isEmpty) return "required field";
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Present Address",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (userCreateFormKey.currentState!.validate()) {

                                          var trainerData = {
                                            "name": name.text,
                                            "email": email.text,
                                            "password": password.text,
                                            "designation": designation.text,
                                            "joiningDate": joiningDate.text,
                                            "yearsOfExperience": yearsOfExperience.text,
                                            "expertises": expertises.text,
                                            "contact": contact.text,
                                            "presentAddress": presentAddress.text,
                                            "role": "TRAINER",
                                          };

                                          createUserProvider.createTrainer(trainerData);
                                        }
                                      },
                                      child: Text("Register Trainer"),
                                    ),
                                  ),
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
            ),
          );
        }
      ),
    );
  }
}
