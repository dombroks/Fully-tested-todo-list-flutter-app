import 'package:hive/hive.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/data/models/TodoModel.dart';

abstract class LocalDataSource {
  Future<Result> getTodoById(int id);
  Future<Result> insertTodo(TodoModel todo);
  Future<Result> removeTodo(TodoModel todo);
}

class DefaulLocalDataSource implements LocalDataSource {
  final HiveInterface hiveInterface;

  DefaulLocalDataSource(this.hiveInterface);

  @override
  Future<Result> getTodoById(int id) async {
    try {
      final todoBox = await hiveInterface.openBox("TodoBox");

      final todo = await todoBox.get(id);
      return Result.completed(todo);
    } catch (e) {
      return Result.error("an error has beee occured" + e.toString());
    }
  }

  @override
  Future<Result> insertTodo(TodoModel todo) async {
    try {
      final todoBox = await hiveInterface.openBox("TodoBox");
      await todoBox.put(todo.id, todo);
      return Result.completed(todo.id);
    } catch (e) {
      return Result.error("an error has beee occured");
    }
  }

  @override
  Future<Result> removeTodo(TodoModel todo) async {
    try {
      final todoBox = await hiveInterface.openBox("TodoBox");
      await todoBox.delete(todo.id);
      return Result.completed("Todo has been well removed");
    } catch (e) {
      return Result.error("an error has beee occured");
    }
  }
}
