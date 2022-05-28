class Todo {
  String? todoMessage;
  String? isCompleted;
  int? id;

  Todo.fromJson(Map json) {
    todoMessage = json["todos"];
    isCompleted = json["isCompleted"];
    id = json["id"] as int;
  }
}