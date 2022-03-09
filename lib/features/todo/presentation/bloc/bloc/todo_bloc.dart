import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/remove_todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final InsertTodoUsecase insertTodoUsecase;
  final RemoveTodoUsecase removeTodoUsecase;
  final GetTodoByIdUsecase getTodoByIdUsecase;
  final GetAllTodosUsecase getAllTodosUsecase;

  TodoBloc(
      {this.getAllTodosUsecase,
      this.insertTodoUsecase,
      this.removeTodoUsecase,
      this.getTodoByIdUsecase})
      : super(Empty());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is InsertTodoEvent) {
      await insertTodoUsecase(event.todo);
    } else if (event is GetTodoByIdEvent) {
      final data = await getTodoByIdUsecase(event.id);
      if (data.data is String)
        yield Error(data.data);
      else {
        yield Loaded(data.data);
      }
    } else if (event is RemoveTodoEvent) {
      final data = await removeTodoUsecase(event.todo);
      if (data.data is String)
        yield Error(data.data);
      else
        yield Loaded(data);
    } else if (event is GetAllTodosEvent) {
      final data = await getAllTodosUsecase();
      if (data.data is String)
        yield Error(data.data);
      else
        yield Loaded(data.data);
    }
  }
}
