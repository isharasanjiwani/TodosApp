

import 'package:flutter/material.dart';
import 'package:todos_app/cubit/add_todo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todos"),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if(state is AddedTodo){
          Navigator.pop(context);
          return;
          }
        },
          child: _body()
      )
    );
  }

  Widget _body(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: controller,
            autofocus: true,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300.0,
              height: 50.0,
              child: ElevatedButton(
                  onPressed: (){
                    final String message = controller.text;
                    BlocProvider.of<AddTodoCubit>(context).addTodo(message);
                  },
                  child: BlocBuilder<AddTodoCubit, AddTodoState>(
                    builder: (context, state) {
                      if(state is AddingTodo)
                        return CircularProgressIndicator();
                      return Text("Submit Todo");
                    }
                  ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
