import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Todo extends Equatable {
  final int id;
  final String title;
  final String content;

  Todo({@required this.id, @required this.title, @required this.content})
      : super();

  @override
  List<Object> get props => [id, title, content];
}
