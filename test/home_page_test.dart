import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory/home_page.dart';

import 'package:memory/main.dart';
import 'package:memory/memory_card_widget.dart';

void main() {
  testWidgets('Test basic memory selection structure',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MemoryApp());

    expect(find.byType(AppBar), findsOneWidget);
    expect(
        find.byKey(const Key("memory_card_selection_title")), findsOneWidget);
    expect(find.byKey(const Key("memory_card_selection")), findsOneWidget);
    expect(find.byType(MemoryCardWidget), findsNWidgets(4));

    for (final number in HomePage.numbers) {
      expect(find.text(number.toString()), findsOneWidget);
    }
  });
}
