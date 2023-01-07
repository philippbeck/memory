import 'package:flutter/material.dart';
import 'package:memory/models/memory_card.dart';

class MemoryCardWidget extends StatelessWidget {
  const MemoryCardWidget({
    required this.card,
    required this.selectMemoryCard,
    Key? key,
  }) : super(key: key);

  final MemoryCard card;
  final Function({required MemoryCard card}) selectMemoryCard;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: card.isOpen ? null : () => selectMemoryCard(card: card),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffD9D9D9),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              card.isOpen ? card.assetImage : "assets/memory_background.jpg",
            ).image,
          ),
        ),
      ),
    );
  }
}
