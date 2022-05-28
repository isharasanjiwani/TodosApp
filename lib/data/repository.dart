import 'package:todos_app/data/network_service.dart';

import 'models/todo.dart';

class Repository {

  NetworkService networkService = NetworkService();

  Repository();

  Future<List<Todo>?> fetchTodos() async {
    if(networkService != null) {
      final todosRaw = await networkService.fetchTodos();
      return todosRaw?.map((e) => Todo.fromJson(e)).toList();
    } else{
      return null;
    }
  }

  Future<bool> changeCompletion(String isCompleted, int? id) async {
    final patchObj = { "isCompleted": isCompleted };
    return await networkService.patchTodo(patchObj, id);
  }

  Future<Todo?> addTodo(String message) async{
    final todoObj = {"todos": message, "isCompleted": "false"};
    final todoMap = await networkService.addTodo(todoObj);
    return todoMap != null ? Todo.fromJson(todoMap): null;
  }

  Future<bool> deleteTodo(int? id) async{
    return await networkService.deleteTodo(id);
  }

  Future<bool> updateTodo(String message, int? id) async {
    final patchObj = { "todos": message };
    return await networkService.patchTodo(patchObj, id);
  }
}