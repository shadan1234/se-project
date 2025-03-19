import 'package:flutter/material.dart';
import 'package:se_project/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get users => _user;

  set users(UserModel? user) {
    _user = user;
    notifyListeners(); // Fixed typo here
  }
}
