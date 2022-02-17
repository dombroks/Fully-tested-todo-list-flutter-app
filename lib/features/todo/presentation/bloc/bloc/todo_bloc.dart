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
    switch (event) {
    }
  }
}
