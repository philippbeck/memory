import 'package:flutter/material.dart';
import 'package:memory/memory_card_widget.dart';
import 'package:memory/memory_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const List<int> _numbers = [4, 6, 8, 10];

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
              child: Text("Wähle die Anzahl der Karten"),
            ),
            const SizedBox(
              height: 49.0,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 60,
              runSpacing: 32,
              children: _numbers
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
    return MemoryCardWidget(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MemoryPage(numberOfCards: number),
        ),
      ),
      text: number.toString(),
    );
  }
}
