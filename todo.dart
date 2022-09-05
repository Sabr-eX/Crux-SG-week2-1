class ToDo {
  final DateTime id;
  final String title;
  final String description;
  final DateTime deadline;
  bool isComplete = false;

  ToDo({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
  });

  ToDo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        deadline = json['deadline'],
        isComplete = json['isComplete'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'deadline': deadline,
    'isComplete': isComplete,
  };
}
