import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/utils/toast_utils.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_utils.dart';
import '../l10n/app_localizations.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier {
  //todo: data
  List<Event> eventsList = [];
  List<Event> filterEventList = [];
  List<Event> favouriteEventList = [];
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
  void getAllEvents(String uId) async {
    //todo: get all events
    QuerySnapshot<Event> querySnapshot =
    await FirebaseUtils.getEventCollection(uId).get();
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

  void getFilterEvents(String uId) async {
    //todo: get all events
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils
        .getEventCollection(uId).get();
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

  void getFilterEventsFromFirestore(String uId) async {
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils
        .getEventCollection(uId)
    //todo: sorting events
        .orderBy('event_date_time')
    //todo: filtering events
        .where('event_name', isEqualTo: eventsNameList[selectedIndex]).get();
    filterEventList = querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    notifyListeners();
  }

  void updateIsFavouriteEvent(Event event, String uId) {
    //todo: 1- update is favourite events
    FirebaseUtils.getEventCollection(uId).doc(event.id)
        .update({
      'is_favorite': !event.isFavorite})
        .then((value) {
      //todo: alert dialog - toast - snack bar
      ToastUtils.showToastMessage(
        message: 'Event Updated Successfully',
        backgroundColor: AppColor.greenColor,
        textColor: AppColor.whiteColor,
      );
    },);
    //todo: 2- get all event ,filter event
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
    //todo: 3- get all favourite event
    // getAllFavouriteEvents();
    getAllFavouriteEvents(uId);
    notifyListeners();
  }

  void getAllFavouriteEvents(String uId) async {
    //todo: get all event
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils
        .getEventCollection(uId).get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    //todo: filter event to get favourite event
    favouriteEventList = eventsList.where((event) {
      return event.isFavorite == true;
    },).toList();
    //todo: sorting event
    favouriteEventList.sort(
          (event1, event2) {
        return event1.eventDateTime.compareTo(event2.eventDateTime);
      },
    );
    notifyListeners();
  }

  void getAllFavouriteEventsFromFirestore(String uId) async {
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils
        .getEventCollection(uId)
    //todo: sorting events
        .orderBy('event_date_time')
    //todo: filtering events
        .where('is_favorite', isEqualTo: true)
        .get();
    favouriteEventList = querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();

    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEventsFromFirestore(uId);
  }
}
