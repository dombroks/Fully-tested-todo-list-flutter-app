import 'package:flutter/material.dart';
import 'package:todo_list/features/todo/presentation/screens/insert_todo_screen.dart';
import 'service_locator.dart' as serviceLocator;

void main() {
  serviceLocator.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InsertTodoScreen(),
    );
  }
}
