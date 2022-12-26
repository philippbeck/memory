import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:memory/home_page.dart';

import 'package:memory/main.dart' as app;
import 'package:memory/memory_card_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('play a game of memory and reset afterwards', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify the 4 selection cards are shown.
    for (final number in HomePage.numbers) {
      expect(find.byKey(Key("memory_card_widget_$number")), findsOneWidget);
      expect(find.text(number.toString()), findsOneWidget);
    }

    // Emulate a tap on the number 8 card.
    await tester.tap(find.byKey(const Key("memory_card_widget_8")));
    await tester.pumpAndSettle();

    int pairs = 0;
    int tries = 0;
    List<MemoryCardWidget> memoryCards = tester
        .widgetList<MemoryCardWidget>(find.byType(MemoryCardWidget))
        .toList();

    // Verify the memory cards are shown and pairs and tries are 0.
    expect(
        find.byType(MemoryCardWidget, skipOffstage: false), findsNWidgets(8));
    for (final memoryCard in memoryCards) {
      expect(memoryCard.card.isOpen, isFalse);
    }
    expect(find.text("Paare: $pairs"), findsOneWidget);
    expect(find.text("Versuche: $tries"), findsOneWidget);

    List<int> wrongMemoryCardIndexes = [];

    // Solve the memory
    while (memoryCards.any((element) => !element.card.isOpen)) {
      // Tap on first card that is not open yet
      int indexOfSelectedCard = memoryCards
          .indexOf(memoryCards.firstWhere((element) => !element.card.isOpen));
      await tester.tap(find.byType(MemoryCardWidget).at(indexOfSelectedCard));
      await tester.pump();

      for (int i = 0; i < 8; i++) {
        // Skip currently selected card and cards that are already solved.
        if (i == indexOfSelectedCard ||
            memoryCards[i].card.isOpen ||
            wrongMemoryCardIndexes.contains(i)) {
          continue;
        }

        // Tap on closed card and check if it was the matching pair
        await tester.tap(find.byType(MemoryCardWidget).at(i));
        // Wait until the cards would be closed again
        await tester.pump(const Duration(milliseconds: 500));

        tries++;

        if (memoryCards[i].card.isOpen) {
          // Matching pair found -> clear list of wrong indexes
          wrongMemoryCardIndexes.clear();
          pairs++;
        } else {
          // Wrong pair -> add index to ignore list
          wrongMemoryCardIndexes.add(i);
        }
        expect(find.text("Paare: $pairs"), findsOneWidget);
        expect(find.text("Versuche: $tries"), findsOneWidget);
        break;
      }
    }

    // Reset the memory
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.text("Paare: 0"), findsOneWidget);
    expect(find.text("Versuche: 0"), findsOneWidget);
    expect(
        find.byType(MemoryCardWidget, skipOffstage: false), findsNWidgets(8));
    for (final memoryCard in memoryCards) {
      expect(memoryCard.card.isOpen, isFalse);
    }
  });
}
