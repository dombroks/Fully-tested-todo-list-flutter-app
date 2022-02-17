part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class Empty extends TodoState {}

class Loading extends TodoState {}

class Loaded extends TodoState {
  final Todo todo;

  Loaded(this.todo);
  

}

class Error extends TodoState {
  final String errorMessage;

  Error(this.errorMessage);
  
  
}