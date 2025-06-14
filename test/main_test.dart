import 'package:flutter_test/flutter_test.dart';
import 'package:temanbicara/main.dart' as app;

void main() {
  testWidgets('Teman Bicara app runs', (tester) async {
    expect(() => app.runTemanBicaraApp(), returnsNormally);
  });
}
