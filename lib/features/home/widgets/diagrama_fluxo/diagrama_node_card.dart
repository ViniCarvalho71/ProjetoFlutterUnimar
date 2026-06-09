import 'package:flutter/material.dart';
import 'package:myapp/features/home/models/diagrama_no_model.dart';
import 'diagrama_node_modal.dart';
import 'diagrama_mini_badge.dart';
import 'diagrama_visual.dart';

class DiagramaNodeCard extends StatelessWidget {
  final DiagramaNoModel diagramaNo;
  final int index;
  final double width;
  final double height;

  const DiagramaNodeCard({
    super.key,
    required this.diagramaNo,
    required this.index,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final no = diagramaNo.no;
    final color = tipoNoColor(no.tipo);
    final icon = tipoNoIcon(no.tipo);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 0,
      child: InkWell(
        onTap: () {
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: 'Fechar',
            barrierColor: Colors.black54,
            transitionDuration: const Duration(
              milliseconds: 250,
            ),

            pageBuilder: (_, __, ___) {
              return DiagramaNodeModal(
                diagramaNo: diagramaNo,
              );
            },

            transitionBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(
                opacity: animation,

                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.92,
                    end: 1.0,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),

                  child: child,
                ),
              );
            },
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: width,
          height: height,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1D3A5F).withValues(alpha: 0.12),
                blurRadius: 22,
                offset: const Offset(0, 14),
              ),
            ],
            border: Border.all(
              color: color.withValues(alpha: 0.34),
              width: 1.3,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      no.tipoLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: scheme.onSurface.withValues(alpha: 0.72),
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  DiagramaMiniBadge(label: diagramaNo.badge, color: color),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    diagramaNo.titulo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          height: 1.18,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      diagramaNo.subtitulo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurface.withValues(alpha: 0.56),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '#${index + 1}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: scheme.onSurface.withValues(alpha: 0.42),
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}