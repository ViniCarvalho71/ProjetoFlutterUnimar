import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/features/home/models/diagrama_no_model.dart';

import 'diagrama_flow_lines_painter.dart';
import 'diagrama_grid_painter.dart';
import 'diagrama_node_card.dart';

class DiagramaCanvas extends StatelessWidget {
  final List<DiagramaNoModel> nos;

  const DiagramaCanvas({super.key, required this.nos});

  static const double cardWidth = 260;
  static const double cardHeight = 152;
  static const double gap = 74;
  static const double edgePadding = 42;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : 360.0;
        final viewportHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : 420.0;
        final diagramWidth =
            (nos.length * cardWidth) + ((nos.length - 1) * gap);
        final canvasWidth = max(
          viewportWidth,
          diagramWidth + (edgePadding * 2),
        );
        final canvasHeight = max(viewportHeight, cardHeight + 160.0);
        final leftPadding = max(edgePadding, (canvasWidth - diagramWidth) / 2);
        final topPadding = max(edgePadding, (canvasHeight - cardHeight) / 2);

        return ClipRect(
          child: InteractiveViewer(
            constrained: false,
            clipBehavior: Clip.none,
            minScale: 0.65,
            maxScale: 2.6,
            boundaryMargin: const EdgeInsets.all(220),
            child: SizedBox(
              width: canvasWidth,
              height: canvasHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: CustomPaint(painter: DiagramaGridPainter()),
                  ),
                  CustomPaint(
                    size: Size(canvasWidth, canvasHeight),
                    painter: DiagramaFlowLinesPainter(
                      itemCount: nos.length,
                      cardSize: const Size(cardWidth, cardHeight),
                      gap: gap,
                      topPadding: topPadding,
                      leftPadding: leftPadding,
                    ),
                  ),
                  for (int index = 0; index < nos.length; index++)
                    Positioned(
                      left: leftPadding + index * (cardWidth + gap),
                      top: topPadding,
                      child: DiagramaNodeCard(
                        diagramaNo: nos[index],
                        index: index,
                        width: cardWidth,
                        height: cardHeight,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
