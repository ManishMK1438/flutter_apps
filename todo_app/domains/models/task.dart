class Task {
  String id;
  String title;
  String description;
  String time;

  Task({required this.id,required this.title, required this.description, required this.time});
  Task.updateTask({required this.id,required this.title,required this.time,required this.description});

  Map<String, dynamic> toJSON(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time,
    };
  }
}