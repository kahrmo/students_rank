import 'package:flutter/material.dart';

class CustomStarRating extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final double size;

  const CustomStarRating({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isFilled = starIndex <= value;
        return IconButton(
          key: ValueKey(starIndex),
          iconSize: size,
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          constraints: const BoxConstraints(),
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
              key: ValueKey(isFilled),
              color: isFilled ? Colors.amber : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
          ),
          onPressed: () {
            onChanged(starIndex);
          },
        );
      }),
    );
  }
}
