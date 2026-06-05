import 'package:flutter/material.dart';
import 'package:myapp/features/home/models/log_fluxo_model.dart';
import 'package:myapp/features/home/widgets/log_fluxo/log_fluxo_tile.dart';

class LogFluxoListView extends StatelessWidget {
  final List<LogFluxoModel> logs;

  const LogFluxoListView({
    super.key,
    required this.logs,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: logs.length,
      itemBuilder: (context, index) {
        return LogFluxoTile(
          logFluxo: logs[index],
        );
      },
    );
  }
}