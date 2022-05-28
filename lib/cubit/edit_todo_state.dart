part of 'edit_todo_cubit.dart';

@immutable
abstract class EditTodoState {}

class EditTodoInitial extends EditTodoState {}
class EditTodoError extends EditTodoState {
  final String? todoError;
  EditTodoError(this.todoError);
}
class EditedTodo extends EditTodoState {}