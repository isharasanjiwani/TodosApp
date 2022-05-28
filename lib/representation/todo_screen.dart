import 'package:flutter/material.dart';
import 'package:todos_app/constants/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todos_cubit.dart';
import '../cubit/todos_state.dart';
import '../data/models/todo.dart';

class TodoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //TodosCubit().fetchTodos();

    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        actions: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, ADD_TODO_ROUTE);
            },
            child: const Padding(
              padding:  EdgeInsets.only(right: 20.0),
              child: Icon(Icons.add,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {

          if(!(state is TodosLoaded))
            return Center(child: CircularProgressIndicator());

          final todos = (state as TodosLoaded).todos;

          return SingleChildScrollView(
            child: Column(
              children:  todos!.map((e) => _todo(e, context)).toList(),
            ),
          );
        },
      )
    );
  }

  Widget _todo(Todo todo, context){
    return InkWell(
      onTap: () => Navigator.pushNamed(context, EDIT_TODO_ROUTE, arguments: todo),
      child: Dismissible(
        key: Key("${todo.id}"),
        background: Container(color: Colors.blueAccent,),
        confirmDismiss: (_) async {
          BlocProvider.of<TodosCubit>(context).changeCompletion(todo);
          return false;
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Text(todo.todoMessage ?? ""),
            Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                  width: 4.0,
                  color: todo.isCompleted != "true" ? Colors.green : Colors.red,
                )
              ),
            )
          ]),
        ),
      ),
    );
  }
}

