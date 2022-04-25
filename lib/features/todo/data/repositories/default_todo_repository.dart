import 'package:todo_list/features/todo/data/data_sources/local/local_data_source.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/repositories/todo_repository.dart';

import '../models/TodoModel.dart';


class DefaultTodoRepository implements TodoRepository {
  final LocalDataSource? localDataSource;

  DefaultTodoRepository(this.localDataSource);
  @override
  Future<Result> getTodoById(String id) {
    return localDataSource!.getTodoById(id);
  }

  @override
  Future<Result> insertTodo(Todo todo) {
    return localDataSource!.insertTodo(todo as TodoModel);
  }

  @override
  Future<Result> removeTodo(Todo todo) {
    return localDataSource!.removeTodo(todo as TodoModel);
  }

  @override
  Future<Result> getAllTodos() {
    return localDataSource!.getAllTodos();
  }
}
