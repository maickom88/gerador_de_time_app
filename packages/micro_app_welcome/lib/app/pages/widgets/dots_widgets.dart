import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final bool isActive;

  const DotWidget({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: AnimatedContainer(
        width: 18,
        height: 18,
        padding: isActive ? const EdgeInsets.all(5) : const EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(
              color: isActive ? Colors.white : Colors.transparent, width: 1),
          shape: BoxShape.circle,
        ),
        duration: const Duration(milliseconds: 300),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
