import 'package:flutter/material.dart';
import 'package:memory/memory_card_widget.dart';
import 'package:memory/models/memory_card.dart';

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
  late final List<MemoryCard> _memoryCards;
  MemoryCard? _currentlySelectedCard;
  int _numberOfTries = 0;
  int _successfulPairs = 0;

  @override
  void initState() {
    int middle = widget.numberOfCards ~/ 2;
    _memoryCards = List.generate(
      widget.numberOfCards,
      (index) {
        int number = index % middle;
        return MemoryCard(
          id: number,
          assetImage: "assets/memory_$number.jpg",
        );
      },
    );
    _memoryCards.shuffle();
    super.initState();
  }

  void _selectMemoryCard({required MemoryCard card}) {
    MemoryCard? selectedCard = _currentlySelectedCard;
    if (selectedCard == null) {
      // First card is selected.
      // Show the value and set as currently selected card.
      setState(() {
        _currentlySelectedCard = card;
        card.isOpen = true;
      });
      return;
    }

    // A card was already selected
    setState(() {
      _currentlySelectedCard = null;
      _numberOfTries++;
    });

    if (selectedCard.id == card.id) {
      setState(() {
        card.isOpen = true;
        _successfulPairs++;
      });
    } else {
      setState(() {
        card.isOpen = true;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            card.isOpen = false;
            selectedCard.isOpen = false;
          });
        }
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
          Text(key: const Key("memory_page_pairs"), "Paare: $_successfulPairs"),
          Text(
              key: const Key("memory_page_tries"), "Versuche: $_numberOfTries"),
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
              card: card,
              selectMemoryCard: _selectMemoryCard,
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
