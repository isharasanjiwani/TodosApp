part of 'add_todo_cubit.dart';

@immutable
abstract class AddTodoState {}

class AddTodoInitial extends AddTodoState {}
class AddTodoError extends AddTodoState {
  final String? todoError;
  AddTodoError(this.todoError);
}
class AddingTodo extends AddTodoState {}
class AddedTodo extends AddTodoState {}
