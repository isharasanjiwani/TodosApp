import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/cubit/todos_cubit.dart';

import '../data/models/todo.dart';
import '../data/repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final Repository? repository;
  final TodosCubit? todosCubit;

  EditTodoCubit({this.repository, this.todosCubit}) : super(EditTodoInitial());

  void deleteTodo(Todo todo){
    repository?.deleteTodo(todo.id).then((value) {
      if(value){
        todosCubit?.deleteTodo(todo);
        emit(EditedTodo());
      }
    });
  }

  void updateTodo(Todo todo, String message) {
    if(message.isEmpty){
      emit(EditTodoError("Message is empty"));
      return;
    }

    repository?.updateTodo(message, todo.id).then((value) {
      if(value){
        todo.todoMessage = message;
        todosCubit?.updateTodoList();
        emit(EditedTodo());
      }
    });
  }
}
