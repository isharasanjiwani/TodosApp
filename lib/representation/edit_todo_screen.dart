import 'package:flutter/material.dart';
import 'package:todos_app/cubit/edit_todo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/todo.dart';

class EditTodoScreen extends StatelessWidget {

  final Todo todo;

  EditTodoScreen({Key? key, required this.todo}) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textEditingController.text = todo.todoMessage ?? "";
    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        if(state is EditedTodo){
          Navigator.pop(context);
        } else if(state is EditTodoError){
          
        }
      },
      child: Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {
                  BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
                },
                  child: const Icon(Icons.delete))
            ],
          ),
          body: _body(context),
    ),
    );
  }

  Widget _body(context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: textEditingController,
            autofocus: true,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: (){
                  BlocProvider.of<EditTodoCubit>(context).updateTodo(todo, textEditingController.text);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ), child: Text("Edit Todo"),
              ),
            ),
          )
        ],
      ),
    );
  }
}