import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/components/todo_widget.dart';

void main() {
  setUp(() {});

  Todo todo = Todo(id: "test id", title: "test title", content: "test content");

  Widget createWidgetUnderTest() => Builder(
      builder: (context) => MaterialApp(
              home: TodoWidget(
            todo: todo,
          )));

  testWidgets("remove button is displayed", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byIcon(Icons.delete), findsOneWidget);
  });

  testWidgets("todo title is displayed", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text(todo.title), findsOneWidget);
  });
}
