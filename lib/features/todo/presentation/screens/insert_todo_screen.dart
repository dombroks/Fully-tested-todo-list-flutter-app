import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/features/todo/data/models/TodoModel.dart';
import 'package:todo_list/features/todo/presentation/change_notifiers/todo_change_notifier.dart';
import 'package:todo_list/features/todo/presentation/screens/todos_screen.dart';
import 'package:uuid/uuid.dart';

const String addButtonKey = "ADD BUTTON KEY";
const String titleTextFieldKey = "TITLE TEXT FIELD KEY";
const String contentTextFieldKey = "CONTENT TEXT FIELD KEY";

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
    var changeNotifier = Provider.of<TodoChangeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        actions: [
          IconButton(
              icon: Icon(Icons.menu),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: TextField(
                key: Key(titleTextFieldKey),
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
                key: Key(contentTextFieldKey),
                controller: contentController,
                decoration: InputDecoration(
                  hintText: "Content",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            FlatButton(
              key: Key(addButtonKey),
              onPressed: () async {
                TodoModel todo = TodoModel(
                    id: Uuid().v1(),
                    title: titleController.text,
                    content: contentController.text);
                changeNotifier.insertTodo(todo);
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
