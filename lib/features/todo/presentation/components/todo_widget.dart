import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/data/models/TodoModel.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/bloc/bloc/todo_bloc.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  const TodoWidget({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        BlocProvider.of<TodoBloc>(context).add(RemoveTodoEvent(
                            TodoModel(
                                id: todo.id,
                                title: todo.title,
                                content: todo.content)));
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
