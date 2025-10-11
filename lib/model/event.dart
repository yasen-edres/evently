class Event {
  //todo: collectionName
  static const String collectionName = 'Events';

  //todo: attributes
  String id;
  String eventImage;
  String title;
  String description;
  String eventName;
  DateTime eventDateTime;
  String eventTime;
  bool isFavorite;

  //todo: constructor
  Event({
    this.id = '',
    required this.title,
    required this.description,
    required this.eventName,
    required this.eventDateTime,
    required this.eventImage,
    required this.eventTime,
    this.isFavorite = false,
  });

  //todo: json => object
  Event.fromFireStore(Map<String, dynamic> data)
    : this(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        eventDateTime: DateTime.fromMillisecondsSinceEpoch(
          data['event_date_time'],
        ),
        eventImage: data['event_image'],
        eventName: data['event_name'],
        eventTime: data['event_time'],
        isFavorite: data['is_favorite'],
      );

  //todo: object => json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'event_name': eventName,
      'event_date_time': eventDateTime.millisecondsSinceEpoch,
      'event_image': eventImage,
      'event_time': eventTime,
      'is_favorite': isFavorite,
    };
  }
}
