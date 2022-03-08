import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Result> insertTodo(Todo todo);
  Future<Result> removeTodo(Todo todo);
  Future<Result> getTodoById(int id);
  Future<Result> getAllTodos();
}
