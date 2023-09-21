import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier{
  bool isSWitched = false;
  void changeGameMode(){
    isSWitched = !isSWitched;
    notifyListeners();
  }
}