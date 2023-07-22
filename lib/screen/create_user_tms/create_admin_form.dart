import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/screen_size.dart';
import '../../provider/create_user_provider.dart';

class CreateAdminForm extends StatelessWidget {
  CreateAdminForm({
    super.key,

  });

  final  name = TextEditingController();
  final  email= TextEditingController();
  final  password= TextEditingController();
  final  contact= TextEditingController();
  final  gender= TextEditingController();
  final  createAdminFormKey= GlobalKey<FormState>();
  //CreateUserProvider createUserProvider  = CreateUserProvider();

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateUserProvider>(
      builder: (context, createUserProvider, child){
        return Form(
          key: createAdminFormKey,
          child: SingleChildScrollView(
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
                          print("yoo");

                          if(createAdminFormKey.currentState!.validate()){
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
        );
      }
    );
  }
}