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
  Future<Result> getTodoById(int id) {
    // TODO: implement getTodoById
    throw UnimplementedError();
  }

  @override
  Future<Result> insertTodo(TodoModel todo) async {
    try {
      final todoBox = await hiveInterface.openBox("TodoBox");
      todoBox.put(todo.id, todo);
      return Result.completed(todo.id);
    } catch (e) {
      return Result.error("an error has beee occured");
    }
  }

  @override
  Future<Result> removeTodo(TodoModel todo) {
    // TODO: implement removeTodo
    throw UnimplementedError();
  }
}
