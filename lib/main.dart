import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:todo_list/features/todo/presentation/screens/Todos_screen.dart';
import 'package:todo_list/features/todo/presentation/screens/insert_todo_screen.dart';
import 'service_locator.dart' as serviceLocator;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator.init();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator.sl<TodoBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo list',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: InsertTodoScreen(),
      ),
    );
  }
}
