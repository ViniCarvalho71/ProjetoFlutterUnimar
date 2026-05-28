import 'package:myapp/features/home/models/fluxo_model.dart';
import 'package:myapp/features/home/models/no_model.dart';

abstract class FluxoDatasource {
  Future<FluxoModel> getFluxoById(int id);

  Future<List<NoModel>> getNosByFluxoId(int fluxoId);
}