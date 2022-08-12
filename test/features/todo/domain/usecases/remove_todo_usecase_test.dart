import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_list/features/todo/domain/usecases/remove_todo_usecase.dart';

import 'get_all_todos_usecase_test.mocks.dart';


void main() {
  late MockTodoRepository mockTodoRepository;
  late RemoveTodoUsecase removeTodoUsecase;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    removeTodoUsecase = RemoveTodoUsecase(mockTodoRepository);
  });

  final todoItem =
      Todo(id: "1", title: "test todo", content: "This is a test todo");

  test('should remove the todo item from repository', () async {
    when(mockTodoRepository.removeTodo(todoItem))
        .thenAnswer((_) async => Result.completed("todo has been well removed"));

    final result = await removeTodoUsecase(todoItem);

    expect(result.data, "todo has been well removed");

    verify(mockTodoRepository.removeTodo(todoItem));
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
