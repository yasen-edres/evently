import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static Future<void> addEventToFireStore(Event event) {
    //todo: 1- create collection
    CollectionReference<Event> collectionRef = getEventCollection();
    //todo: 2- create document
    DocumentReference<Event> documentRef = collectionRef.doc();
    //todo: 3- assign auto doc id to event id
    event.id = documentRef.id; //todo: auto id
    //todo: 4- save data
    return documentRef.set(event);
  }
}
