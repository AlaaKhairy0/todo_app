class ToDoDM {
  static const String collectionName = 'Todos';
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  ToDoDM({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.dateTime,
  });

  Map<String, dynamic> toFireStore() => {
        'id': id,
        'title': title,
        'description': description,
        'dateTime': dateTime,
        'isDone': isDone,
      };

  ToDoDM.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            description: data['description'],
            dateTime: data['dateTime'].toDate(),
            isDone: data['isDone']);
}
