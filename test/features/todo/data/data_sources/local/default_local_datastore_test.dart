import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
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

  TodoModel tTodoModel = TodoModel(id: 1, title: "title", content: "content");

  test('insertTodo should save todo on Local DB', () async {
    when(mockHive.openBox(any)).thenAnswer((_) async => mockHiveBox);

    await defaulLocalDataSource.insertTodo(tTodoModel);

    verify(mockHiveBox.put(tTodoModel.id, tTodoModel));
  });
}
