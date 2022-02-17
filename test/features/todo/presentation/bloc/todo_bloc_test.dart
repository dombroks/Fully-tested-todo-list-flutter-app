import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:todo_list/features/todo/presentation/bloc/bloc/todo_bloc.dart';

class MockInsertTodoUsecase extends Mock implements InsertTodoUsecase {}

class MockRemoveTodoUsecase extends Mock implements RemoveTodoUsecase {}

class MockGetTodoByIdUsecase extends Mock implements GetTodoByIdUsecase {}

void main() {
  TodoBloc bloc;
  MockInsertTodoUsecase mockInsertTodoUsecase;
  MockRemoveTodoUsecase mockRemoveTodoUsecase;
  MockGetTodoByIdUsecase mockGetTodoByIdUsecase;

  setUp(() {
    mockInsertTodoUsecase = MockInsertTodoUsecase();
    mockRemoveTodoUsecase = MockRemoveTodoUsecase();
    mockGetTodoByIdUsecase = MockGetTodoByIdUsecase();
    bloc = TodoBloc(
        insertTodoUsecase: mockInsertTodoUsecase,
        removeTodoUsecase: mockRemoveTodoUsecase,
        getTodoByIdUsecase: mockGetTodoByIdUsecase);
  });

  test('the bloc s initial state should be [Empty]', () {
    expect(bloc.state, equals(Empty()));
  });

  Todo tTodo = Todo(id: 1, title: "title", content: "content");

  test('should return a [Loaded] state when calling insertTodo', () {
    when(mockInsertTodoUsecase(any))
        .thenAnswer((_) async => Result.completed(tTodo.id));

    bloc.add(InsertTodoEvent(tTodo));

    expectLater(bloc.asBroadcastStream(), emitsInOrder([Loaded(tTodo.id)]));
  });

  test('should return a [Loaded] state when calling removeTodo', () {
    when(mockRemoveTodoUsecase(any))
        .thenAnswer((_) async => Result.completed(tTodo.id));

    bloc.add(RemoveTodoEvent(tTodo));

    expectLater(bloc.asBroadcastStream(), emitsInOrder([Loaded("")]));
  });

  test('should return a [Loaded] state when calling getTodoById', () {
    when(mockGetTodoByIdUsecase(any))
        .thenAnswer((_) async => Result.completed(tTodo.id));

    bloc.add(GetTodoByIdEvent(tTodo.id));

    expectLater(bloc.asBroadcastStream(), emitsInOrder([Loaded(tTodo)]));
  });
}
