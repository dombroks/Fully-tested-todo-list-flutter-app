import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/repositories/todo_repository.dart';

class GetTodoByIdUsecase {
  final TodoRepository todoRepository;

  GetTodoByIdUsecase(this.todoRepository);

  Future<Result> call(String id) async {
    final data = await todoRepository.getTodoById(id);
    return data;
  }
}
