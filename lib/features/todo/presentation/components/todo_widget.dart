import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/features/todo/data/models/TodoModel.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/change_notifiers/todo_change_notifier.dart';
import 'package:todo_list/features/todo/presentation/screens/todo_screen.dart';

class TodoWidget extends StatelessWidget {
  final Todo? todo;
  const TodoWidget({Key? key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => TodoScreen(
                      todo: todo,
                    )));
      },
      child: Card(
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
                      todo!.title!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          Provider.of<TodoChangeNotifier>(context,
                                  listen: false)
                              .removeTodo(TodoModel(
                                  id: todo!.id,
                                  title: todo!.title,
                                  content: todo!.content));
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
