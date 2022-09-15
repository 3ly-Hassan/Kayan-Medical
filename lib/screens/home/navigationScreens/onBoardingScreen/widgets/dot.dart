import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  const Dot({Key? key, required this.isActive}) : super(key: key);
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 5),
        height: isActive ? 20 : 8,
        width: isActive ? 20 : 8,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.lightGreen : Colors.grey),
      ),
    );
  }
}
