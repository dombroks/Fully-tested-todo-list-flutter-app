import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/remove_todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final InsertTodoUsecase insertTodoUsecase;
  final RemoveTodoUsecase removeTodoUsecase;
  final GetTodoByIdUsecase getTodoByIdUsecase;

  TodoBloc(
      {this.insertTodoUsecase, this.removeTodoUsecase, this.getTodoByIdUsecase})
      : super(Empty());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is InsertTodoEvent) {
      final data = await insertTodoUsecase(event.todo);
      if (data.data is String)
        yield Error(data.data);
      else
        yield Loaded(insertTodoUsecase(event.todo));
    } else if (event is GetTodoByIdEvent) {
      final data = await getTodoByIdUsecase(event.id);
      if (data.data is String)
        yield Error(data.data);
      else {
        yield Loading();
        yield Loaded(data.data);
      }
    } else if (event is RemoveTodoEvent) {
      final data = await removeTodoUsecase(event.todo);
      if (data.data is String)
        yield Error(data.data);
      else
        yield Loaded(data);
    }
  }
}
