import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/usecases/insert_todo_usecase.dart';

import 'get_all_todos_usecase_test.mocks.dart';



void main() {
  late MockTodoRepository mockTodoRepository;
  late InsertTodoUsecase insertTodoUsecase;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    insertTodoUsecase = InsertTodoUsecase(mockTodoRepository);
  });

  final todoItem =
      Todo(id: "1", title: "test todo", content: "This is a test todo");

  test('should insert the todo item to repository', () async {
    when(mockTodoRepository.insertTodo(todoItem))
        .thenAnswer((_) async => Result.completed(1));

    final result = await insertTodoUsecase(todoItem);

    expect(result.data, 1);

    verify(mockTodoRepository.insertTodo(todoItem));
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
