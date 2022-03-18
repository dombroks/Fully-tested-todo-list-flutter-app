import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/screens/todo_screen.dart';

void main() {
  setUp(() {});

  Todo todo = Todo(id: "test id", title: "test title", content: "test content");

  Widget createWidgetUnderTest() => Builder(
        builder: (context) => MaterialApp(
            home: TodoScreen(
          todo: todo,
        )),
      );

  testWidgets("appBar's title is displayed", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text("Todo"), findsOneWidget);
  });

  testWidgets("todo's title and content are displayed",
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text("Title: "), findsOneWidget);
    expect(find.text("Content: "), findsOneWidget);

    expect(find.text(todo.title), findsOneWidget);
    expect(find.text(todo.content), findsOneWidget);

    await tester.pumpAndSettle();
  });
}
