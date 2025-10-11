import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_utils.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier {
  //todo: data
  List<Event> eventsList = [];

  //todo: function
  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }
}
