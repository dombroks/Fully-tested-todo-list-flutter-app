part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class InsertTodoEvent extends TodoEvent {
  final Todo todo;

  InsertTodoEvent(this.todo);
  
   @override
  List<Object> get props => [todo];
}

class RemoveTodoEvent extends TodoEvent {
  final Todo todo;

  RemoveTodoEvent(this.todo);
  
   @override
  List<Object> get props => [todo];
}

class GetTodoByIdEvent extends TodoEvent {
  final int id;

  GetTodoByIdEvent(this.id);
  
   @override
  List<Object> get props => [id];
}

class GetAllTodosEvent extends TodoEvent {

  GetAllTodosEvent();
  
   @override
  List<Object> get props => [];
}

