import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:todo_list/features/todo/presentation/components/todo_widget.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key key}) : super(key: key);

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
    BlocProvider.of<TodoBloc>(context).add(GetAllTodosEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is Loaded)
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: ListView.builder(
                        itemCount: state.result.length,
                        itemBuilder: (BuildContext context, index) {
                          return Center(
                              child: TodoWidget(
                            todo: state.result[index],
                          ));
                        })),
              );
            else if (state is Loading)
              return Text("Loading..");
            else
              return Text("Error");
          },
        ),
      ),
    );
  }
}
