import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory/home_page.dart';

import 'package:memory/main.dart';

void main() {
  testWidgets('Test basic memory selection structure',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MemoryApp());

    expect(find.byType(AppBar), findsOneWidget);
    expect(
        find.byKey(const Key("memory_card_selection_title")), findsOneWidget);
    expect(find.byKey(const Key("memory_card_selection")), findsOneWidget);

    for (final number in HomePage.numbers) {
      expect(find.byKey(Key("memory_card_widget_$number")), findsOneWidget);
      expect(find.text(number.toString()), findsOneWidget);
    }
  });
}
