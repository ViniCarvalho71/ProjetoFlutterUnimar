import 'package:myapp/features/home/models/integracao_model.dart';

abstract class IntegracaoDataSource {
  Future<List<IntegracaoModel>> getIntegracoes({String pesquisa = ''});
}
