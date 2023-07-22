import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class TrainerMenuProvider with ChangeNotifier{
  bool profile = true;
  bool batch = false;
  bool createAD = false;
  bool createTR = false;
  bool createTE = false;
  bool logout = false;

  void onClickSideMenu(int c){
    profile = false;
    batch = false;
    createAD = false;
    createTR = false;
    createTE = false;
    logout = false;
    if(c==1) profile = true;
    if(c==2) batch = true;
    if(c==3) logout = true;
    notifyListeners();

  }



  void saveTokenToLocalStorage(String token) {
    final storage = html.window.localStorage;
    storage['token'] = token;
    notifyListeners();
  }

  String? getTokenFromLocalstorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }

  void saveRoleToLocalStorage(String role) {
    final storage = html.window.localStorage;
    storage['role'] = role;
    print(role);
    notifyListeners();
  }

  String? getRoleFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['role'];
  }
}