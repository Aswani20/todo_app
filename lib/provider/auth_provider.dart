import 'package:flutter/material.dart';
import 'package:todoapp/model/mu_user.dart';

class AuthProvider extends ChangeNotifier{
  MyUser? currentUser;

  void updateUser(MyUser newUser){
    currentUser = newUser;
    notifyListeners();
  }
}