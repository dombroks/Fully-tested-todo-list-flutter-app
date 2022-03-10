import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:todo_list/features/todo/presentation/bloc/bloc/todo_bloc.dart';

class MockInsertTodoUsecase extends Mock implements InsertTodoUsecase {}

class MockRemoveTodoUsecase extends Mock implements RemoveTodoUsecase {}

class MockGetTodoByIdUsecase extends Mock implements GetTodoByIdUsecase {}

class MockGetAllTodosUsecase extends Mock implements GetAllTodosUsecase {}

void main() {
  TodoBloc bloc;
  MockInsertTodoUsecase mockInsertTodoUsecase;
  MockRemoveTodoUsecase mockRemoveTodoUsecase;
  MockGetTodoByIdUsecase mockGetTodoByIdUsecase;
  MockGetAllTodosUsecase mockGetAllTodosUsecase;

  setUp(() {
    mockInsertTodoUsecase = MockInsertTodoUsecase();
    mockRemoveTodoUsecase = MockRemoveTodoUsecase();
    mockGetTodoByIdUsecase = MockGetTodoByIdUsecase();
    mockGetAllTodosUsecase = MockGetAllTodosUsecase();
    bloc = TodoBloc(
        insertTodoUsecase: mockInsertTodoUsecase,
        removeTodoUsecase: mockRemoveTodoUsecase,
        getTodoByIdUsecase: mockGetTodoByIdUsecase,
        getAllTodosUsecase: mockGetAllTodosUsecase);
  });

  tearDown(() {
    bloc.close();
  });

  test('the bloc s initial state should be [Empty]', () {
    expect(bloc.state, equals(Empty()));
  });

  Todo tTodo = Todo(id: "1", title: "title", content: "content");

  test('should return a [Loaded] state when calling insertTodoUsecase', () {
    when(mockInsertTodoUsecase(any))
        .thenAnswer((_) async => Result.completed(tTodo.id));

    bloc.add(InsertTodoEvent(tTodo));

    expectLater(bloc.asBroadcastStream(), emitsInOrder([Loaded(tTodo.id)]));
  });

  test('should return a [Loaded] state when calling removeTodoUsecase', () {
    when(mockRemoveTodoUsecase(any))
        .thenAnswer((_) async => Result.completed(tTodo.id));

    bloc.add(RemoveTodoEvent(tTodo));

    expectLater(bloc.asBroadcastStream(), emitsInOrder([Loaded("")]));
  });

  test('should return a [Loaded] state when calling getTodoByIdUsecase', () {
    when(mockGetTodoByIdUsecase(any))
        .thenAnswer((_) async => Result.completed(tTodo.id));

    bloc.add(GetTodoByIdEvent(tTodo.id));

    expectLater(bloc.asBroadcastStream(), emitsInOrder([Loaded(tTodo)]));
  });

  test('should insert a todo item when calling insertTodoUsecase', () async {
    when(mockInsertTodoUsecase(any))
        .thenAnswer((_) async => Result.completed(tTodo.id));

    bloc.add(InsertTodoEvent(tTodo));
    await untilCalled(mockInsertTodoUsecase(any));

    verify(mockInsertTodoUsecase(tTodo));
  });

  test('should get a todo item when calling getTodoByIdUsecase', () async {
    when(mockGetTodoByIdUsecase(any))
        .thenAnswer((_) async => Result.completed(tTodo));

    bloc.add(GetTodoByIdEvent(tTodo.id));
    await untilCalled(mockGetTodoByIdUsecase(any));

    verify(mockGetTodoByIdUsecase(tTodo.id));
  });

  test('should remove the todo item when calling removeTodoUsecase', () async {
    when(mockRemoveTodoUsecase(any)).thenAnswer(
        (_) async => Result.completed("seccessful removing message"));

    bloc.add(RemoveTodoEvent(tTodo));
    await untilCalled(mockRemoveTodoUsecase(any));

    verify(mockRemoveTodoUsecase(tTodo));
  });

  test('should emit [Loading, Loaded] when data is gotten', () async {
    when(mockGetTodoByIdUsecase(any))
        .thenAnswer((_) async => Result.completed(tTodo));

    bloc.add(GetTodoByIdEvent(tTodo.id));

    expectLater(
        bloc.asBroadcastStream(), emitsInOrder([Loading(), Loaded(tTodo)]));
  });

  test('should get all the todos when calling getAllTodosUsecase', () async {
    List<Todo> todos = [
      Todo(id: "1", title: "title", content: "content"),
      Todo(id: "1", title: "title", content: "content")
    ];
    when(mockGetAllTodosUsecase())
        .thenAnswer((_) async => Result.completed(todos));

    bloc.add(GetAllTodosEvent());
    await untilCalled(mockGetAllTodosUsecase());

    verify(mockGetAllTodosUsecase());
  });
}
