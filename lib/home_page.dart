import 'package:flutter/material.dart';
import 'package:memory/memory_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @visibleForTesting
  static const List<int> numbers = [4, 6, 8, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memory"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 21.0),
        child: Column(
          children: [
            const Center(
              key: Key("memory_card_selection_title"),
              child: Text("Wähle die Anzahl der Karten"),
            ),
            const SizedBox(
              height: 49.0,
            ),
            Wrap(
              key: const Key("memory_card_selection"),
              alignment: WrapAlignment.center,
              spacing: 60,
              runSpacing: 32,
              children: numbers
                  .map((number) =>
                      _getNumberOfCardsButton(context: context, number: number))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _getNumberOfCardsButton(
      {required BuildContext context, required int number}) {
    return InkWell(
      key: Key("memory_card_widget_$number"),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MemoryPage(numberOfCards: number),
        ),
      ),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffD9D9D9),
        ),
        child: Center(
          child: Text(number.toString()),
        ),
      ),
    );
  }
}
