import 'package:bloc/bloc.dart';
import 'package:todos_app/cubit/todos_state.dart';
import 'package:todos_app/data/repository.dart';

import '../data/models/todo.dart';

class TodosCubit extends Cubit<TodosState> {
  
   Repository repository = Repository();
  
  TodosCubit() : super(TodosInitial());
  
  void fetchTodos() {
    repository.fetchTodos().then((todos) {
      emit(TodosLoaded(todos: todos));
    }).catchError((e){
      print(e.toString());
    });
  }

   void changeCompletion(Todo todo){
    if(todo.isCompleted == "true") {
      repository.changeCompletion("false", todo.id).then((isChanged) {
        if(isChanged) {
          todo.isCompleted = "false";
          updateTodoList();
        }
      });
    } else {
      repository.changeCompletion("true", todo.id).then((isChanged) {
        if(isChanged) {
          todo.isCompleted = "true";
          updateTodoList();
        }
      });
    }
  }

  void updateTodoList() {
    final currentState = state;
    if(currentState is TodosLoaded) {
      emit(TodosLoaded(todos: currentState.todos));
    }
   }

   addTodo(Todo todo){
     final currentState = state;
     if(currentState is TodosLoaded) {
       final todoList = currentState.todos;
       todoList?.add(todo);
       emit(TodosLoaded(todos: todoList));
     }
   }
}