import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/repositories/todo_repository.dart';

class GetTodoByIdUsecase {
  final TodoRepository todoRepository;

  GetTodoByIdUsecase(this.todoRepository);

  Future<Result> call(int id) async{
    return await todoRepository.getTodoById(id);
  }
}
