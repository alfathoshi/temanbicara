// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

class FakeImageWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const FakeImageWidget({this.width, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 100,
      height: height ?? 100,
      color: Colors.grey,
    );
  }
}

class DummyGetStorage implements GetStorage {
  final Map<String, dynamic> _store = {};

  @override
  T? read<T>(String key) => _store[key] as T?;

  @override
  Future<void> write(String key, dynamic value) async {
    _store[key] = value;
  }

  @override
  bool hasData(String key) => _store.containsKey(key);

  // Optional: implement other GetStorage members if needed
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('Sanity check - Hello World renders', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Hello World'),
        ),
      ),
    );

    expect(find.text('Hello World'), findsOneWidget);
  });
}
