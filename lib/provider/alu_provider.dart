import 'package:flutter/material.dart';


class ALU_Provider with ChangeNotifier{

  bool flag = false;

  void changeFlag(bool flag){
    this.flag = flag;
    notifyListeners();
  }

}