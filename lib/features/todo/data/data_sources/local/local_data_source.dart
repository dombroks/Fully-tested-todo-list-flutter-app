import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/data/models/TodoModel.dart';

abstract class LocalDataSource {
  Future<Result> getTodoById(int id);
  Future<Result> insertTodo(TodoModel todo);
  Future<Result> removeTodo(TodoModel todo);
}

class DefaulLocalDataSource implements LocalDataSource{
  @override
  Future<Result> getTodoById(int id) {
      // TODO: implement getTodoById
      throw UnimplementedError();
    }
  
    @override
    Future<Result> insertTodo(TodoModel todo) {
      // TODO: implement insertTodo
      throw UnimplementedError();
    }
  
    @override
    Future<Result> removeTodo(TodoModel todo) {
    // TODO: implement removeTodo
    throw UnimplementedError();
  }
  
}
