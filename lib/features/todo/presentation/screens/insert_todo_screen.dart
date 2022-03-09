import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/data/models/TodoModel.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:todo_list/features/todo/presentation/screens/Todos_screen.dart';

class InsertTodoScreen extends StatefulWidget {
  const InsertTodoScreen({Key key}) : super(key: key);

  @override
  _InsertTodoScreenState createState() => _InsertTodoScreenState();
}

class _InsertTodoScreenState extends State<InsertTodoScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TodosScreen()));
              })
        ],
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: TextField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: "Content",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            FlatButton(
              onPressed: () {
                print("button has been pressed");
                TodoModel todo =
                    TodoModel(id: 1, title: "text", content: "est.sgqtext");

                BlocProvider.of<TodoBloc>(context).add(InsertTodoEvent(todo));
              },
              child: Container(
                color: Colors.blue,
                height: 50,
                child: Center(
                    child: Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
