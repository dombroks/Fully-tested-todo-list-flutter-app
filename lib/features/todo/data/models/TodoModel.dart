import 'package:meta/meta.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel(
      {required String? id, required String? title, required String? content})
      : super(id: id, title: title, content: content);

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        id: json['id'], title: json['title'], content: json['content']);
  }

  Map<String, dynamic> toJson() {
    return {"id": this.id, "title": this.title, "content": this.content};
  }
}
