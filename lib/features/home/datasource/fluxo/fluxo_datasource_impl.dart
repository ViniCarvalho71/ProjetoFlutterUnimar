import 'package:dio/dio.dart';
import 'package:myapp/features/core/errors/exceptions/conectasti_exception.dart';
import 'package:myapp/features/core/network/api_endpoints.dart';
import 'package:myapp/features/core/network/conectasti_api_client.dart';
import 'package:myapp/features/home/datasource/fluxo/fluxo_datasource.dart';
import 'package:myapp/features/home/models/fluxo_model.dart';
import 'package:myapp/features/home/models/no_model.dart';

class FluxoDatasourceImpl implements FluxoDatasource {
  final ConectaSTIApiClient apiClient;

  FluxoDatasourceImpl(this.apiClient);

  @override
  Future<FluxoModel> getFluxoById(int id) async {
    try{
      final response = await apiClient.dio.get('${ApiEndpoints.fluxoVersionado}/$id');
      if(response.statusCode != 200) {
        throw ConectastiException('Erro ao buscar fluxo: ${response.statusCode}');
      }
      return FluxoModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ConectastiException('Erro ao buscar fluxo: ${e.message}');
    }
  }

  @override
  Future<List<NoModel>> getNosByFluxoId(int fluxoId) async {
    try{
      FluxoModel fluxo = await getFluxoById(fluxoId);

      final operacoes = [...fluxo.payload.operacoes]
        ..sort((a, b) => a.ordem.compareTo(b.ordem));

      final noIds = operacoes.map((operacao) => operacao.noId).toSet().toList();

      final response = await apiClient.dio.get('/api/No', queryParameters: {'ids': noIds.join(',')});

      print('Response data: ${response.data}');
    } on DioException catch (e) {
      throw ConectastiException('Erro ao buscar nós do fluxo: ${e.message}');
    }
    return [];
  }
}
