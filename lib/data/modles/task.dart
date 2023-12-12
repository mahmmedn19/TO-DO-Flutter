class TodoItem {
  int? id;
  String? title;
  String? description;
  bool? isCompleted = false;
  DateTime? date;

  TodoItem(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.isCompleted});

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      title: json['title'],
      date: json['dateTime'] == null ? null : DateTime.parse(json['dateTime']),
      description: json['description'],
      isCompleted: json['isCompleted'] == 0 ? false : true,
    );
  }

  // Convert Task to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'dateTime': date?.toIso8601String(),
      'description': description,
      'isCompleted': isCompleted == false ? 1 : 0,
    };
  }
}
