import 'package:farmersapp/model/user_model.dart';
import 'package:flutter/material.dart';
import '../methods/authmethods.dart';
class UserProvider with ChangeNotifier {
  Usermodel? _user;
  Usermodel get getuser => _user!;
  Future<void> refreshuser() async {
    Usermodel user = await AuthMethods().getUserDetails();
    _user = user;
    notifyListeners();
  }
}
