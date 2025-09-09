class TodoModel {
  String? id;
  String? title;
  bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  static List<TodoModel> todoList() {
    return [
      TodoModel(id: '1', title: 'Linkedin Post', isDone: true),
      TodoModel(id: '2', title: 'Complete Assignment', isDone: true),
      TodoModel(id: '3', title: 'Grocery Shopping'),
      TodoModel(id: '4', title: 'Morning Exercise', isDone: true),
      TodoModel(id: '5', title: 'Read a Book'),
      TodoModel(id: '6', title: 'Check Emails', isDone: true),
      TodoModel(id: '7', title: 'Plan Weekend Trip'),
      TodoModel(id: '8', title: 'Watch a Movie'),
      TodoModel(id: '9', title: 'Clean the House'),
    ];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isDone': isDone,
  };

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    id: json['id'],
    title: json['title'],
    isDone: json['isDone'],
  );
}
