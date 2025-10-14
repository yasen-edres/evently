import 'package:events/model/my_user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  //todo: data
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
