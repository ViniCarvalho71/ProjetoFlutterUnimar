import 'package:myapp/features/core/network/conectasti_api_client.dart';
import 'package:myapp/features/home/datasource/log_fluxo/log_fluxo_datasource.dart';
import 'package:myapp/features/home/models/log_fluxo_model.dart';

class LogFluxoDatasourceImpl implements LogFluxoDatasource {
  final ConectaSTIApiClient apiClient;
  LogFluxoDatasourceImpl(this.apiClient);
  
  @override
  Future<List<LogFluxoModel>> getLogs() async {
    final response = await apiClient.dio.get('/api/LogFluxo');

    return (response.data as List)
        .map((e) => LogFluxoModel.fromJson(e))
        .toList();
  }
}