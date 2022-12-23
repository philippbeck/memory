import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const List<int> _numbers = [4, 6, 8, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memory"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 21.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Wähle die Anzahl der Karten",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            const SizedBox(
              height: 49.0,
            ),
            Wrap(
              spacing: 60,
              runSpacing: 32,
              children: _numbers
                  .map((number) => _getNumberOfCardsButton(number: number))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _getNumberOfCardsButton({required int number}) {
    return InkWell(
      onTap: () {},
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
