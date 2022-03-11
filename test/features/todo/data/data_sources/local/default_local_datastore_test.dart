import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/data/data_sources/local/local_data_source.dart';
import 'package:todo_list/features/todo/data/models/TodoModel.dart';

class MockHive extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

void main() {
  MockHive mockHive;
  MockHiveBox mockHiveBox;
  DefaulLocalDataSource defaulLocalDataSource;

  setUp(() {
    mockHive = MockHive();
    mockHiveBox = MockHiveBox();
    defaulLocalDataSource = DefaulLocalDataSource(mockHive);
  });

  TodoModel tTodoModel = TodoModel(id: "1", title: "title", content: "content");

  test('insertTodo should save todo on Local DB', () async {
    when(mockHive.openBox(any)).thenAnswer((_) async => mockHiveBox);

    await defaulLocalDataSource.insertTodo(tTodoModel);

    verify(mockHiveBox.put(tTodoModel.id, tTodoModel));
  });

  test('getTodoById should return a todo', () async {
    when(mockHive.openBox(any)).thenAnswer((_) async => mockHiveBox);
    when(mockHiveBox.get(tTodoModel.id)).thenAnswer((_) async => tTodoModel);

    final result = await defaulLocalDataSource.getTodoById(tTodoModel.id);

    expect(result.data, tTodoModel);
    verify(mockHiveBox.get(tTodoModel.id));
  });

  test('removeTodo should remove a todo from DB', () async {
    when(mockHive.openBox(any)).thenAnswer((_) async => mockHiveBox);
    when(mockHiveBox.delete(tTodoModel.id)).thenAnswer(
        (_) async => Result.completed("Todo has been well removed"));

    final result = await defaulLocalDataSource.removeTodo(tTodoModel);

    expect(result.data, "Todo has been well removed");
    verify(mockHiveBox.delete(tTodoModel.id));
  });

  test('getAllTodos should get all the inserted todos from DB', () async {
    List<TodoModel> todos = [
      TodoModel(id: "1", title: "title", content: "content"),
      TodoModel(id: "1", title: "title", content: "content")
    ];
    when(mockHive.openBox(any)).thenAnswer((_) async => mockHiveBox);
    when(mockHiveBox.values).thenReturn(todos);

    final result = await defaulLocalDataSource.removeTodo(tTodoModel);

    expect(result.data, "Todo has been well removed");
    verify(mockHiveBox.delete(tTodoModel.id));
  });
}
