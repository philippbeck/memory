class MemoryCard {
  MemoryCard({
    required this.id,
    this.isOpen = false,
    required this.assetImage,
  });
  int id;
  bool isOpen;
  String assetImage;
}
