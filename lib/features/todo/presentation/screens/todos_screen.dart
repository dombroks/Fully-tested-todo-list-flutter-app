import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/features/todo/presentation/change_notifiers/todo_change_notifier.dart';
import 'package:todo_list/features/todo/presentation/components/todo_widget.dart';

const String progressIndicatorKey = "PROGRESS INDICATOR KEY";

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    Provider.of<TodoChangeNotifier>(context, listen: false).getAllTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var changeNotifier = Provider.of<TodoChangeNotifier>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title: Text("Todos"),
        ),
        body: Container(
            width: screenSize.width,
            height: screenSize.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<TodoChangeNotifier>(
                builder: (context, notifier, child) {
                  if (notifier.todos.length == 0) {
                    return Center(
                      child: CircularProgressIndicator(
                        key: Key(progressIndicatorKey),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: changeNotifier.todos.length,
                        itemBuilder: (BuildContext context, index) {
                          var data = changeNotifier.todos;
                          return TodoWidget(
                            todo: data[index],
                          );
                        });
                  }
                },
              ),
            )));
  }
}
