import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? content;

  Todo({required this.id, required this.title, required this.content});

  @override
  List<Object?> get props => [id, title, content];
}
