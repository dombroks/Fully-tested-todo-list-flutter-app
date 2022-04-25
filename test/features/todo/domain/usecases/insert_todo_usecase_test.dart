import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_list/features/todo/domain/usecases/insert_todo_usecase.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  MockTodoRepository? mockTodoRepository;
  late InsertTodoUsecase insertTodoUsecase;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    insertTodoUsecase = InsertTodoUsecase(mockTodoRepository);
  });

  final todoItem =
      Todo(id: "1", title: "test todo", content: "This is a test todo");

  test('should insert the todo item to repository', () async {
    when(mockTodoRepository!.insertTodo(todoItem))
        .thenAnswer((_) async => Result.completed(1));

    final result = await insertTodoUsecase(todoItem);

    expect(result.data, 1);

    verify(mockTodoRepository!.insertTodo(todoItem));
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
