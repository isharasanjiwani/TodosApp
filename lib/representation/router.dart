import 'package:flutter/material.dart';
import 'package:todos_app/constants/strings.dart';
import 'package:todos_app/cubit/add_todo_cubit.dart';
import 'package:todos_app/cubit/todos_cubit.dart';
import 'package:todos_app/data/network_service.dart';
import 'package:todos_app/data/repository.dart';
import 'package:todos_app/representation/add_todo_screen.dart';
import 'package:todos_app/representation/edit_todo_screen.dart';
import 'package:todos_app/representation/todo_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {

  Repository? repository;
  late final TodosCubit todosCubit;

  AppRouter() {
    repository = Repository();
    todosCubit = TodosCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (_) => BlocProvider.value(
          value: todosCubit,
          child: TodoScreen(),));
      case EDIT_TODO_ROUTE:
        return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (BuildContext context) => AddTodoCubit(repository: repository, todosCubit: todosCubit),
            child: EditTodoScreen()));
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (BuildContext context) => AddTodoCubit(repository: repository, todosCubit: todosCubit),
            child: AddTodoScreen()));
      default:
        return null;
    }
  }
}