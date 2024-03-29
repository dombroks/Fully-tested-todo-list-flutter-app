import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/change_notifiers/todo_change_notifier.dart';
import 'package:todo_list/features/todo/presentation/screens/insert_todo_screen.dart';
import 'package:todo_list/features/todo/presentation/screens/todos_screen.dart';

import '../test/features/todo/presentation/change_notifiers/todo_change_notifier_test.mocks.dart';


void main() {
  late TodoChangeNotifier todoChangeNotifier;
  late MockGetAllTodosUsecase mockGetAllTodosUsecase;
  late MockGetTodoByIdUsecase mockGetTodoByIdUsecase;
  late MockInsertTodoUsecase mockInsertTodoUsecase;
  late MockRemoveTodoUsecase mockRemoveTodoUsecase;
  setUp(() {
    mockGetAllTodosUsecase = MockGetAllTodosUsecase();
    mockGetTodoByIdUsecase = MockGetTodoByIdUsecase();
    mockInsertTodoUsecase = MockInsertTodoUsecase();
    mockRemoveTodoUsecase = MockRemoveTodoUsecase();
    todoChangeNotifier = TodoChangeNotifier(
        getAllTodosUsecase: mockGetAllTodosUsecase,
        getTodoByIdUsecase: mockGetTodoByIdUsecase,
        insertTodoUsecase: mockInsertTodoUsecase,
        removeTodoUsecase: mockRemoveTodoUsecase);
  });

  Widget createWidgetUnderTest() => ChangeNotifierProvider(
      create: (_) => todoChangeNotifier,
      child: Builder(
        builder: (context) => MaterialApp(
          home: InsertTodoScreen(),
        ),
      ));

  testWidgets(
      "Tapping on the add icon in the appbar will lead to the todos screen",
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();
    when(mockGetAllTodosUsecase()).thenAnswer((_) async =>
        Result.completed([Todo(id: "1", title: "title", content: "content")]));
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(InsertTodoScreen), findsNothing);
    expect(find.byType(TodosScreen), findsOneWidget);
  });
}
