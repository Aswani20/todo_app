class Task {
  static const collectionName = 'tasks';
  String? id;
  String? title;
  String? description;
  DateTime? dataTime;
  bool? isDone;

  Task({
    this.id = '',
    required this.title,
    required this.dataTime,
    required this.description,
    this.isDone = false
  });

  Task.fromFireStore(Map<String, dynamic> data) :this(
    id: data['id'],
    title: data['title'],
    description: data['description'],
    dataTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    isDone: data['isDone'],

  );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dataTime!.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }

}