import 'package:flutter/material.dart';
import 'package:memory/memory_card_widget.dart';

class MemoryPage extends StatefulWidget {
  const MemoryPage({
    required this.numberOfCards,
    Key? key,
  }) : super(key: key);

  final int numberOfCards;

  @override
  State<MemoryPage> createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {
  static const _colors = [
    Colors.green,
    Colors.yellow,
    Colors.cyan,
    Colors.deepOrangeAccent,
    Colors.pinkAccent
  ];
  late final List<_MemoryCard> _memoryCards;
  _MemoryCard? _currentlySelectedCard;
  int _numberOfTries = 0;
  int _successfulPairs = 0;

  @override
  void initState() {
    int middle = widget.numberOfCards ~/ 2;
    _memoryCards = List.generate(
        widget.numberOfCards,
        (index) => _MemoryCard(
            number: index % middle,
            isOpen: false,
            backgroundColor: _colors[index % middle]));
    _memoryCards.shuffle();
    super.initState();
  }

  void _selectMemoryCard({required _MemoryCard card}) {
    _MemoryCard? selectedCard = _currentlySelectedCard;
    // Check whether a card was already selected
    if (selectedCard != null) {
      setState(() {
        _currentlySelectedCard = null;
        _numberOfTries++;
        if (selectedCard.number == card.number) {
          card.isOpen = true;
          _successfulPairs++;
        } else {
          card.isOpen = true;
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() {
                card.isOpen = false;
                selectedCard.isOpen = false;
              });
            }
          });
        }
      });
    } else {
      // First card is selected.
      // Show the value and set as currently selected card.
      setState(() {
        _currentlySelectedCard = card;
        card.isOpen = true;
      });
    }
  }

  // Resets all values and shuffles the list.
  void _resetMemory() {
    setState(() {
      _numberOfTries = 0;
      _successfulPairs = 0;
      for (final memoryCard in _memoryCards) {
        memoryCard.isOpen = false;
      }
      _memoryCards.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memory"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 31.0,
          horizontal: 20.0,
        ),
        children: [
          _getMemoryCardsWrap(),
          const SizedBox(
            height: 79.0,
          ),
          Text("Paare: $_successfulPairs"),
          Text("Versuche: $_numberOfTries"),
        ],
      ),
      floatingActionButton: _getResetButton(),
    );
  }

  Widget _getMemoryCardsWrap() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 18,
      runSpacing: 31,
      children: _memoryCards
          .map(
            (card) => MemoryCardWidget(
              onTap: card.isOpen ? null : () => _selectMemoryCard(card: card),
              text: card.isOpen ? card.number.toString() : "?",
              color: card.isOpen ? card.backgroundColor : null,
            ),
          )
          .toList(),
    );
  }

  Widget _getResetButton() {
    return SizedBox(
      width: 67,
      height: 67,
      child: FloatingActionButton(
        onPressed: _resetMemory,
        child: const Icon(
          Icons.refresh,
          size: 52,
        ),
      ),
    );
  }
}

class _MemoryCard {
  _MemoryCard({
    required this.number,
    required this.isOpen,
    required this.backgroundColor,
  });
  int number;
  bool isOpen;
  Color backgroundColor;
}
