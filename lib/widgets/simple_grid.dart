import 'package:flutter/material.dart';

class SimpleGrid extends StatelessWidget {
  const SimpleGrid(
      {super.key,
      required this.children,
      required this.crossAxisCount,
      this.spacing = 8,
      this.runSpacing = 8});
  final List<Widget> children;
  final int crossAxisCount;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final spacingCount = crossAxisCount - 1;
      final spacingWidth = spacing * spacingCount;
      final width = constraints.biggest.width - spacingWidth;
      return Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children: [
          for (final child in children)
            SizedBox(width: width / crossAxisCount, child: child)
        ],
      );
    });
  }
}
