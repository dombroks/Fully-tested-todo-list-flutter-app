import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/repositories/todo_repository.dart';

class GetAllTodosUsecase {
  final TodoRepository? todoRepository;

  GetAllTodosUsecase(this.todoRepository);

  Future<Result> call() async {
    final data = await todoRepository!.getAllTodos();
    return data;
  }
}
