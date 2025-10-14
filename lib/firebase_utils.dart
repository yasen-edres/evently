import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/model/event.dart';
import 'package:events/model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static Future<void> addEventToFireStore(Event event, String uId) {
    //todo: 1- create collection
    CollectionReference<Event> collectionRef = getEventCollection(uId);
    //todo: 2- create document
    DocumentReference<Event> documentRef = collectionRef.doc();
    //todo: 3- assign auto doc id to event id
    event.id = documentRef.id; //todo: auto id
    //todo: 4- save data
    return documentRef.set(event);
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapShot = await getUserCollection().doc(id).get();
    return querySnapShot.data();

    ///MyUse?
  }
}
