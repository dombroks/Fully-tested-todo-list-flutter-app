import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:todo_list/service_locator.dart';

class InsertTodoScreen extends StatelessWidget {
  const InsertTodoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: BlocProvider(
        create: (_) => serviceLocator<TodoBloc>(),
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Content",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  onPressed: () {},
                  child: Container(
                    color: Colors.blue,
                    width: screenSize.width,
                    height: 45,
                    child: Center(child: Text("Add")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
