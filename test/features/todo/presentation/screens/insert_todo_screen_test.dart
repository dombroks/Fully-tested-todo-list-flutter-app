import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/features/todo/presentation/change_notifiers/todo_change_notifier.dart';
import 'package:todo_list/features/todo/presentation/screens/insert_todo_screen.dart';

void main() {
  setUp(() {});

  Widget createWidgetUnderTest() => ChangeNotifierProvider(
      create: (_) => TodoChangeNotifier(),
      child: Builder(
        builder: (context) => MaterialApp(
          home: InsertTodoScreen(),
        ),
      ));

  testWidgets("appBar's title is displayed", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text("Add Todo"), findsOneWidget);
  });

  testWidgets("appBar's add icon is displayed", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets("the two TextFields are displayed", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets("the add button is displayed",
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byKey(Key("ADD BUTTON KEY")), findsOneWidget);
    expect(find.text("Add"), findsOneWidget);
  });

  testWidgets("bla bla", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();
    await tester.tap(find.byKey(Key("ADD BUTTON KEY")));
    await tester.pumpAndSettle();
    expect(find.byKey(Key("ADD BUTTON KEY")), findsOneWidget);
  });
}
