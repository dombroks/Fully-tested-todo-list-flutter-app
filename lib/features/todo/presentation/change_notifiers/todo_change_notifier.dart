import 'package:flutter/material.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/remove_todo_usecase.dart';

class TodoChangeNotifier extends ChangeNotifier {
  final InsertTodoUsecase insertTodoUsecase;
  final RemoveTodoUsecase removeTodoUsecase;
  final GetTodoByIdUsecase getTodoByIdUsecase;
  final GetAllTodosUsecase getAllTodosUsecase;

  TodoChangeNotifier(
      {this.insertTodoUsecase,
      this.removeTodoUsecase,
      this.getTodoByIdUsecase,
      this.getAllTodosUsecase});

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<void> getAllTodos() async {
    var data = await getAllTodosUsecase();
    _todos.clear();
    _todos.addAll(data.data);
    notifyListeners();
  }

  Future<void> insertTodo(Todo todo) async {
    await insertTodoUsecase(todo);
  }
}
