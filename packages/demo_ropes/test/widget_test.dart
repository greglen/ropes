import 'package:flutter_test/flutter_test.dart';

import 'package:demo_ropes/main.dart';

void main() {
  testWidgets('Demo rope smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });
}
