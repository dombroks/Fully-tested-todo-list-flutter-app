import 'package:hive/hive.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/data/models/TodoModel.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

abstract class LocalDataSource {
  Future<Result> getTodoById(String id);
  Future<Result> insertTodo(TodoModel todo);
  Future<Result> removeTodo(TodoModel todo);
  Future<Result> getAllTodos();
}

class DefaulLocalDataSource implements LocalDataSource {
  final HiveInterface hiveInterface;

  DefaulLocalDataSource(this.hiveInterface);

  @override
  Future<Result> getTodoById(String id) async {
    final todoBox = await hiveInterface.openBox("TodoBox");

    final todo = await todoBox.get(id);
    return Result.completed(todo as Todo);
  }

  @override
  Future<Result> insertTodo(TodoModel todo) async {
    final todoBox = await hiveInterface.openBox("TodoBox");
    todoBox.put(todo.id, todo);
    return Result.completed(todo.id);
  }

  @override
  Future<Result> removeTodo(TodoModel todo) async {
    final todoBox = await hiveInterface.openBox("TodoBox");

    await todoBox.delete(todo.id);
    return Result.completed("Todo has been well removed");
  }

  @override
  Future<Result> getAllTodos() async {
    final todoBox = await hiveInterface.openBox("TodoBox");

    final todos = todoBox.values.toList().cast<Todo>();

    return Result.completed(todos);
  }
}
