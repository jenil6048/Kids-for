import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kidsfor/widgets/custom_text.dart';

void main() {
  testWidgets('CustomText widget builds and renders text', (WidgetTester tester) async {
    // Build the CustomText widget inside a MaterialApp.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomText('Hello Explorer!'),
        ),
      ),
    );

    // Verify that the text 'Hello Explorer!' is rendered.
    expect(find.text('Hello Explorer!'), findsOneWidget);
  });
}
