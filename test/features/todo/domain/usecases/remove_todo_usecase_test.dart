import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_list/features/todo/domain/usecases/remove_todo_usecase.dart';

class MockTodoRepository extends Mock implements TodoRepository {}


void main() {
  MockTodoRepository mockTodoRepository;
  RemoveTodoUsecase removeTodoUsecase;

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
