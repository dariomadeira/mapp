import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {

  String _userName;
  String _userImagePath;

  // SETTERS
  set setUserName(String userName) {
    this._userName = userName;
    notifyListeners();
  }

  set setUserImagePath(String imagePath) {
    this._userImagePath = imagePath;
    notifyListeners();
  }

  // GETTERS
  String get getUserName => this._userName;
  String get getUserImagePath => this._userImagePath;

}