import 'package:flutter/material.dart';
import 'package:todos_app/cubit/todos_cubit.dart';
import 'package:todos_app/representation/router.dart';
import 'package:todos_app/representation/todo_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(TodoApp(
    appRouter: AppRouter(),
  ));
}

class TodoApp extends StatelessWidget {

  final AppRouter? appRouter;

  const TodoApp({Key? key, this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter?.generateRoute,
      home: BlocProvider(
        create: (_) => TodosCubit(),
        child: TodoScreen()
      )
      );
  }
}
