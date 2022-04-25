import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:todo_list/features/todo/presentation/change_notifiers/todo_change_notifier.dart';

class MockInsertTodoUsecase extends Mock implements InsertTodoUsecase {}

class MockRemoveTodoUsecase extends Mock implements RemoveTodoUsecase {}

class MockGetAllTodosUsecase extends Mock implements GetAllTodosUsecase {}

class MockGetTodoByIdUsecase extends Mock implements GetTodoByIdUsecase {}

void main() {
  MockInsertTodoUsecase? mockInsertTodoUsecase;
  MockGetAllTodosUsecase? mockGetAllTodosUsecase;
  MockGetTodoByIdUsecase mockGetTodoByIdUsecase;
  MockRemoveTodoUsecase mockRemoveTodoUsecase;

  late TodoChangeNotifier todoChangeNotifier;

  setUp(() {
    mockGetAllTodosUsecase = MockGetAllTodosUsecase();
    mockGetTodoByIdUsecase = MockGetTodoByIdUsecase();
    mockRemoveTodoUsecase = MockRemoveTodoUsecase();
    mockInsertTodoUsecase = MockInsertTodoUsecase();

    todoChangeNotifier = TodoChangeNotifier(
        getAllTodosUsecase: mockGetAllTodosUsecase,
        removeTodoUsecase: mockRemoveTodoUsecase,
        getTodoByIdUsecase: mockGetTodoByIdUsecase,
        insertTodoUsecase: mockInsertTodoUsecase);
  });

  test("should find correct initial values", () {
    expect(todoChangeNotifier.todos, []);
  });

  Todo tTodo = Todo(id: "100", title: "test title", content: "test content");

  test("insertTodo should be called succesfully", () async {
    await todoChangeNotifier.insertTodo(tTodo);
    verify(mockInsertTodoUsecase!(tTodo));
    verifyNoMoreInteractions(mockInsertTodoUsecase);
  });

  test("getAllTodos should return data succesfully", () async {
    when(mockGetAllTodosUsecase!())
        .thenAnswer((_) async => Result.completed([tTodo]));
    await todoChangeNotifier.getAllTodos();
    expect(todoChangeNotifier.todos, [tTodo]);
    verify(mockGetAllTodosUsecase!());
    verifyNoMoreInteractions(mockGetAllTodosUsecase);
  });
}
