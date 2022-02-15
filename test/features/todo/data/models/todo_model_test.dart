import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/features/todo/data/models/TodoModel.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

import '../../../../fixtures/utils.dart';

void main() {
  final tTodoModel = TodoModel(
      id: 1, title: "Test todoModel", content: "This a test todo model");

  test('should be a subclass of Todo', () {
    expect(tTodoModel, isA<Todo>());
  });

  test('from json should return a valid TodoModel', () {
    final Map<String, dynamic> jsonMap = json.decode(fixture("todo.json"));

    final result = TodoModel.fromJson(jsonMap);

    expect(result, equals(tTodoModel));
  });

  test('to json should return a valid json for a TodoModel', () {
    final result = tTodoModel.toJson();

    expect(result, {
      "id": 1,
      "title": "Test todoModel",
      "content": "This a test todo model"
    });
  });
}
