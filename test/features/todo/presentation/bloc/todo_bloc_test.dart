import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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

  test('the bloc s initial state should be empty', () {
    expect(bloc.state, equals(Empty()));
  });
}
