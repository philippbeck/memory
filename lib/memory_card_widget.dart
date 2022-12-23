import 'package:flutter/material.dart';

class MemoryCardWidget extends StatelessWidget {
  const MemoryCardWidget({
    required this.onTap,
    required this.text,
    this.color,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? const Color(0xffD9D9D9),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
