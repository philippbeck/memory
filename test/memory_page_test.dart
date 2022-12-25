import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:memory/memory_card_widget.dart';
import 'package:memory/memory_page.dart';

void main() {
  Widget getBasicAppStructure({required int numberOfCards}) {
    return MaterialApp(
      home: Material(child: MemoryPage(numberOfCards: numberOfCards)),
    );
  }

  testWidgets('Test basic memory page structure', (WidgetTester tester) async {
    await tester.pumpWidget(getBasicAppStructure(
      numberOfCards: 4,
    ));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byKey(const Key("memory_page_pairs")), findsOneWidget);
    expect(find.byKey(const Key("memory_page_tries")), findsOneWidget);
    expect(find.text("Paare: 0"), findsOneWidget);
    expect(find.text("Versuche: 0"), findsOneWidget);
    expect(find.byType(MemoryCardWidget), findsNWidgets(4));
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Tap on wrong pair', (WidgetTester tester) async {
    int numberOfCards = 4;
    await tester.pumpWidget(getBasicAppStructure(
      numberOfCards: numberOfCards,
    ));

    expect(find.text("Paare: 0"), findsOneWidget);
    expect(find.text("Versuche: 0"), findsOneWidget);
    expect(find.byType(MemoryCardWidget), findsNWidgets(numberOfCards));

    List<MemoryCardWidget> memoryCards = tester
        .widgetList<MemoryCardWidget>(find.byType(MemoryCardWidget))
        .toList();

    // Get two different memory cards
    int memoryIndex0 =
        memoryCards.indexWhere((element) => element.card.id == 0);
    int memoryIndex1 =
        memoryCards.indexWhere((element) => element.card.id == 1);

    // Tap on first memory card
    await tester.tap(find.byType(MemoryCardWidget).at(memoryIndex0));
    await tester.pump();

    // Validate if only one memory card is shown
    for (int i = 0; i < memoryCards.length; i++) {
      expect(
          (tester.widget(find.byType(MemoryCardWidget).at(i))
                  as MemoryCardWidget)
              .card
              .isOpen,
          i == memoryIndex0 ? isTrue : isFalse);
    }

    // Tap on second memory card that is not equal to the first one
    await tester.tap(find.byType(MemoryCardWidget).at(memoryIndex1));
    await tester.pump();

    // Validate if the two tapped memory cards are shown
    for (int i = 0; i < memoryCards.length; i++) {
      expect(
          (tester.widget(find.byType(MemoryCardWidget).at(i))
                  as MemoryCardWidget)
              .card
              .isOpen,
          i == memoryIndex0 || i == memoryIndex1 ? isTrue : isFalse);
    }

    // Wait until the cards will be closed again
    await tester.pump(const Duration(milliseconds: 500));

    // Validate that no memory cards are shown
    for (int i = 0; i < memoryCards.length; i++) {
      expect(
          (tester.widget(find.byType(MemoryCardWidget).at(i))
                  as MemoryCardWidget)
              .card
              .isOpen,
          isFalse);
    }

    expect(find.text("Paare: 0"), findsOneWidget);
    expect(find.text("Versuche: 1"), findsOneWidget);
  });

  testWidgets('Tap on matching pair and reset memory',
      (WidgetTester tester) async {
    int numberOfCards = 4;
    await tester.pumpWidget(getBasicAppStructure(
      numberOfCards: numberOfCards,
    ));

    expect(find.text("Paare: 0"), findsOneWidget);
    expect(find.text("Versuche: 0"), findsOneWidget);
    expect(find.byType(MemoryCardWidget), findsNWidgets(numberOfCards));

    List<MemoryCardWidget> memoryCards = tester
        .widgetList<MemoryCardWidget>(find.byType(MemoryCardWidget))
        .toList();

    // Get two matching memory cards
    int firstMemoryIndex0 =
        memoryCards.indexWhere((element) => element.card.id == 0);
    int secondMemoryIndex0 =
        memoryCards.lastIndexWhere((element) => element.card.id == 0);

    // Tap on first memory card
    await tester.tap(find.byType(MemoryCardWidget).at(firstMemoryIndex0));
    await tester.pump();

    // Validate if only one memory card is shown
    for (int i = 0; i < memoryCards.length; i++) {
      expect(
          (tester.widget(find.byType(MemoryCardWidget).at(i))
                  as MemoryCardWidget)
              .card
              .isOpen,
          i == firstMemoryIndex0 ? isTrue : isFalse);
    }

    // Tap on second memory card that is equal to the first one
    await tester.tap(find.byType(MemoryCardWidget).at(secondMemoryIndex0));
    await tester.pump();

    // Validate if the two tapped memory cards are shown
    for (int i = 0; i < memoryCards.length; i++) {
      expect(
          (tester.widget(find.byType(MemoryCardWidget).at(i))
                  as MemoryCardWidget)
              .card
              .isOpen,
          i == firstMemoryIndex0 || i == secondMemoryIndex0 ? isTrue : isFalse);
    }

    // Wait until the cards would be closed again
    await tester.pump(const Duration(milliseconds: 500));

    // Validate that the memory cards are still shown
    for (int i = 0; i < memoryCards.length; i++) {
      expect(
          (tester.widget(find.byType(MemoryCardWidget).at(i))
                  as MemoryCardWidget)
              .card
              .isOpen,
          i == firstMemoryIndex0 || i == secondMemoryIndex0 ? isTrue : isFalse);
    }

    expect(find.text("Paare: 1"), findsOneWidget);
    expect(find.text("Versuche: 1"), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Validate that no memory cards are shown
    for (int i = 0; i < memoryCards.length; i++) {
      expect(
          (tester.widget(find.byType(MemoryCardWidget).at(i))
                  as MemoryCardWidget)
              .card
              .isOpen,
          isFalse);
    }

    expect(find.text("Paare: 0"), findsOneWidget);
    expect(find.text("Versuche: 0"), findsOneWidget);
  });
}
