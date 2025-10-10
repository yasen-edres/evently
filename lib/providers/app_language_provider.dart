import 'package:flutter/cupertino.dart';

class AppLanguageProvider extends ChangeNotifier {
  //todo: data - function.
  String appLanguage = "en";

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }
}
