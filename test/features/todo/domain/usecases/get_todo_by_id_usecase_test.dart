import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_by_id_usecase.dart';

import 'get_all_todos_usecase_test.mocks.dart';


void main() {
  late MockTodoRepository mockTodoRepository;
  late GetTodoByIdUsecase getTodoByIdUsecase;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    getTodoByIdUsecase = GetTodoByIdUsecase(mockTodoRepository);
  });

  final todoId = "1";
  final todoItem =
      Todo(id: todoId, title: "test todo", content: "This is a test todo");

  test('should get the todo item by its id from repository', () async {
    when(mockTodoRepository.getTodoById(todoId)).thenAnswer(
        (_) async => Result.completed(todoItem));

    final result = await getTodoByIdUsecase(todoId);

    expect(result.data, todoItem);

    verify(mockTodoRepository.getTodoById(todoId));
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
