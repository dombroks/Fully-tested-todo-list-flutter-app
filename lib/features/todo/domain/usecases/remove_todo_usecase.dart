import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repositories/todo_repository.dart';

class RemoveTodoUsecase {
  final TodoRepository todoRepository;

  RemoveTodoUsecase(this.todoRepository);

  Future<Result> call(Todo todo) async{
    return await todoRepository.removeTodo(todo);
  }
}
