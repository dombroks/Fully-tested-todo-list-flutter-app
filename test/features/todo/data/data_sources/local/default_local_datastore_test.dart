import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/data/data_sources/local/local_data_source.dart';
import 'package:todo_list/features/todo/data/models/TodoModel.dart';

import 'default_local_datastore_test.mocks.dart';

@GenerateMocks([HiveInterface, Box])
void main() {
  late MockHiveInterface mockHive;
  late MockBox mockHiveBox;
  late DefaultLocalDataSource defaultLocalDataSource;

  setUp(() {
    mockHive = MockHiveInterface();
    mockHiveBox = MockBox();
    defaultLocalDataSource = DefaultLocalDataSource(mockHive);
  });

  TodoModel tTodoModel = TodoModel(id: "1", title: "title", content: "content");

  test('insertTodo should save todo on Local DB', () async {
    when(mockHive.openBox("TodoBox")).thenAnswer(((_) async => mockHiveBox));

    await defaultLocalDataSource.insertTodo(tTodoModel);

    verify(mockHiveBox.put(tTodoModel.id, tTodoModel));
  });

  test('getTodoById should return a todo', () async {
    when(mockHive.openBox("TodoBox")).thenAnswer(((_) async => mockHiveBox));
    when(mockHiveBox.get(tTodoModel.id)).thenAnswer((_) async => tTodoModel);

    final result = await defaultLocalDataSource.getTodoById(tTodoModel.id);

    expect(result.data, tTodoModel);
    verify(mockHiveBox.get(tTodoModel.id));
  });

  test('removeTodo should remove a todo from DB', () async {
    when(mockHive.openBox("TodoBox")).thenAnswer(((_) async => mockHiveBox));
    when(mockHiveBox.delete(tTodoModel.id)).thenAnswer(
        (_) async => Result.completed("Todo has been well removed"));

    final result = await defaultLocalDataSource.removeTodo(tTodoModel);

    expect(result.data, "Todo has been well removed");
    verify(mockHiveBox.delete(tTodoModel.id));
  });

  test('getAllTodos should get all the inserted todos from DB', () async {
    List<TodoModel> todos = [
      TodoModel(id: "1", title: "title", content: "content"),
      TodoModel(id: "1", title: "title", content: "content")
    ];
    when(mockHive.openBox("TodoBox")).thenAnswer(((_) async => mockHiveBox));
    when(mockHiveBox.values).thenReturn(todos);

    final result = await defaultLocalDataSource.removeTodo(tTodoModel);

    expect(result.data, "Todo has been well removed");
    verify(mockHiveBox.delete(tTodoModel.id));
  });
}
