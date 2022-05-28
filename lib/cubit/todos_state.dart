import 'package:flutter/material.dart';
import 'package:todos_app/data/models/todo.dart';

@immutable
abstract class TodosState{}

class TodosInitial extends TodosState{}
class TodosLoaded extends TodosState{
  List<Todo>? todos;

  TodosLoaded({this.todos});
}