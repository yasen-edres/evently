import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_utils.dart';
import '../l10n/app_localizations.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier {
  //todo: data
  List<Event> eventsList = [];
  List<Event> filterEventList = [];
  List<String> eventsNameList = [];
  int selectedIndex = 0;

  List<String> getEventsNameList(BuildContext context) {
    return eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workShop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
  }

  //todo: function
  void getAllEvents() async {
    //todo: get all events
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterEventList = eventsList;
    //todo: sorting events
    filterEventList.sort(
          (event1, event2) {
        return event1.eventDateTime.compareTo(event2.eventDateTime);
      },
    );

    notifyListeners();
  }

  void getFilterEvents() async {
    //todo: get all events
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils
        .getEventCollection().get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    //todo: filtering events
    filterEventList = eventsList.where((event) {
      return event.eventName == eventsNameList[selectedIndex];
    },).toList();
    //todo: sorting events
    filterEventList.sort(
          (event1, event2) {
        return event1.eventDateTime.compareTo(event2.eventDateTime);
      },
    );
    notifyListeners();
  }

  void getFilterEventsFromFirestore() async {
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils
        .getEventCollection()
    //todo: sorting events
        .orderBy('event_date_time')
    //todo: filtering events
        .where('event_name', isEqualTo: eventsNameList[selectedIndex]).get();
    filterEventList = querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvents() : getFilterEventsFromFirestore();
  }
}
