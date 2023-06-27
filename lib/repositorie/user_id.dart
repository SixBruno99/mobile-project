import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  late String userId;

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }
}