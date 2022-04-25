import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/data/data_sources/local/local_data_source.dart';
import 'package:todo_list/features/todo/data/models/TodoModel.dart';
import 'package:todo_list/features/todo/data/repositories/default_todo_repository.dart';

class MockLocalDataSource extends Mock implements DefaultLocalDataSource {}

void main() {
  late DefaultTodoRepository defaultTodoRepository;
  MockLocalDataSource? mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    defaultTodoRepository = DefaultTodoRepository(mockLocalDataSource);
  });

  final TodoModel tTodoModel = TodoModel(
      id: "1", title: "this is a test title", content: "this is a test content");

  test('getTodoById should return a model', () async {
    when(mockLocalDataSource!.getTodoById("1"))
        .thenAnswer((_) async => Result.completed(tTodoModel));

    final result = await defaultTodoRepository.getTodoById("1");

    expect(result.data, tTodoModel);
    verify(mockLocalDataSource!.getTodoById("1"));
    verifyNoMoreInteractions(mockLocalDataSource);
  });

  test('removeTodo should work successfully', () async {
    when(mockLocalDataSource!.removeTodo(tTodoModel))
        .thenAnswer((_) async => Result.completed("Todo has been well removed"));

    final result = await defaultTodoRepository.removeTodo(tTodoModel);

    expect(result.data, "Todo has been well removed");
    verify(mockLocalDataSource!.removeTodo(tTodoModel));
    verifyNoMoreInteractions(mockLocalDataSource);
  });

  test('insertTodo should insert and return an id', () async {
    when(mockLocalDataSource!.insertTodo(tTodoModel))
        .thenAnswer((_) async => Result.completed(tTodoModel.id));

    final result = await defaultTodoRepository.insertTodo(tTodoModel);

    expect(result.data, tTodoModel.id);
    verify(mockLocalDataSource!.insertTodo(tTodoModel));
    verifyNoMoreInteractions(mockLocalDataSource);
  });

   test('getAllTodos should return all the records', () async {
      List<TodoModel> todos = [
      TodoModel(id: "1", title: "title", content: "content"),
      TodoModel(id: "1", title: "title", content: "content")
    ];
    when(mockLocalDataSource!.getAllTodos())
        .thenAnswer((_) async => Result.completed(todos));

    final result = await defaultTodoRepository.getAllTodos();

    expect(result.data, todos);
    verify(mockLocalDataSource!.getAllTodos());
    verifyNoMoreInteractions(mockLocalDataSource);
  });
}
