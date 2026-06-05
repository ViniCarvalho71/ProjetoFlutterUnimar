import 'package:myapp/features/home/models/log_fluxo_model.dart';

abstract class LogFluxoDatasource {
  Future<List<LogFluxoModel>> getLogs();
}