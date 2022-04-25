import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/util/result.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:todo_list/features/todo/presentation/change_notifiers/todo_change_notifier.dart';

import '../../../../../integration_test/app_test.dart';

@GenerateMocks([
  InsertTodoUsecase,
  RemoveTodoUsecase,
  GetAllTodosUsecase,
  GetTodoByIdUsecase
])
void main() {
  late MockInsertTodoUsecase mockInsertTodoUsecase;
  late MockGetAllTodosUsecase mockGetAllTodosUsecase;
  late MockGetTodoByIdUsecase mockGetTodoByIdUsecase;
  late MockRemoveTodoUsecase mockRemoveTodoUsecase;

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

  test("insertTodo should be called successfully", () async {
    await todoChangeNotifier.insertTodo(tTodo);
    verify(mockInsertTodoUsecase(tTodo));
    verifyNoMoreInteractions(mockInsertTodoUsecase);
  });

  test("getAllTodos should return data successfully", () async {
    when(mockGetAllTodosUsecase())
        .thenAnswer((_) async => Result.completed([tTodo]));
    await todoChangeNotifier.getAllTodos();
    expect(todoChangeNotifier.todos, [tTodo]);
    verify(mockGetAllTodosUsecase());
    verifyNoMoreInteractions(mockGetAllTodosUsecase);
  });
}
