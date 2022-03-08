import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;

  Todo({@required this.id, @required this.title, @required this.content})
      : super();
}
