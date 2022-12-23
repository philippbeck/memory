import 'package:flutter/material.dart';

class MemoryCardWidget extends StatelessWidget {
  const MemoryCardWidget({
    required this.onTap,
    this.text,
    this.image,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String? text;
  final DecorationImage? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffD9D9D9),
          image: image,
        ),
        child: Center(
          child: Text(text ?? ""),
        ),
      ),
    );
  }
}
