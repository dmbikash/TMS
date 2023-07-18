import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_management_system/provider/login_provider.dart';
import 'package:universal_html/html.dart' as html;


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, loginProvider, child){
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val){
                      if(val!.isEmpty){
                        return "khali rakha jabena";
                      }
                    },
                    controller: _email,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val){
                      if(val!.isEmpty){
                        return "khali rakha jabena";
                      }
                    },
                    controller: _password,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      // After successful login
                     // await loginProvider.get_role( _email.text, _password.text);
                      await loginProvider.get_role( 'superadmin@gmail.com', 'admin');
                      print(loginProvider.role);
                      if(loginProvider.role == "TRAINEE"){
                        Navigator.pushNamed(context, "TraineeDashboard");
                      }else  if(loginProvider.role == "ADMIN"){
                        Navigator.pushNamed(context, "AdminDashboard");
                      }else  if(loginProvider.role == "TRAINER"){
                        Navigator.pushNamed(context, "TrainerDashboard");
                      }
                      else{
                        print("golmal hain vai sab golmall hain");

                    }
                    }else{
                      print("form invalid");
                    }
                    //Navigator.pushNamed(context, "Home");
                  },
                  child: const Text("Login"),
                )
              ],
            ),
          );
        },
      ),
    );
  }


}
