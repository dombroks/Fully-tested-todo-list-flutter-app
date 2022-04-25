import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:todo_list/features/todo/presentation/change_notifiers/todo_change_notifier.dart';
import 'package:todo_list/features/todo/presentation/screens/todos_screen.dart';

class MockInsertTodoUsecase extends Mock implements InsertTodoUsecase {}

class MockRemoveTodoUsecase extends Mock implements RemoveTodoUsecase {}

class MockGetAllTodosUsecase extends Mock implements GetAllTodosUsecase {}

class MockGetTodoByIdUsecase extends Mock implements GetTodoByIdUsecase {}

void main() {
  TodoChangeNotifier? todoChangeNotifier;
  MockGetAllTodosUsecase? mockGetAllTodosUsecase;
  MockGetTodoByIdUsecase mockGetTodoByIdUsecase;
  MockInsertTodoUsecase mockInsertTodoUsecase;
  MockRemoveTodoUsecase mockRemoveTodoUsecase;
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

  List<Todo> todos = [
    Todo(id: "test id", title: "test title", content: "test content"),
    Todo(id: "test id2", title: "test title2", content: "test content2")
  ];

  Widget createWidgetUnderTest() => ChangeNotifierProvider(
      create: (_) => todoChangeNotifier,
      child: Builder(
        builder: (context) => MaterialApp(home: TodosScreen()),
      ));

  testWidgets("appBar's title is displayed", (WidgetTester tester) async {
    when(mockGetAllTodosUsecase!()).thenAnswer((_) async {
      return Result.completed(todos);
    });

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text("Todos"), findsOneWidget);
  });

  testWidgets("loading indicator is displayed while loading the todos",
      (WidgetTester tester) async {
    when(mockGetAllTodosUsecase!()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return Result.completed(todos);
    });

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byKey(Key("PROGRESS INDICATOR KEY")), findsOneWidget);
    await tester.pumpAndSettle();
  });

  testWidgets("todos are displayed", (WidgetTester tester) async {
    when(mockGetAllTodosUsecase!()).thenAnswer((_) async {
      return Result.completed(todos);
    });

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text(todos[0].title!), findsOneWidget);
    expect(find.text(todos[1].title!), findsOneWidget);
  });
}
