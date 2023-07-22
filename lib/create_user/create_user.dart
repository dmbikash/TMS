
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
import '../screen/create_user_tms/create_admin_form.dart';
import '../screen/create_user_tms/create_trainee_form.dart';
import '../screen/create_user_tms/create_trainer_form.dart';



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
                       // if(createUserProvider.adminFlag) CreateAdminForm(),

                       //  if (createUserProvider.traineeFlag) Expanded(
                       //      flex: 4,
                       //      child: CreateTraineeForm(),
                       //    ),

                        if (createUserProvider.trainerFlag) Expanded(
                            flex: 4,
                            child: CreateTrainerForm(),
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






