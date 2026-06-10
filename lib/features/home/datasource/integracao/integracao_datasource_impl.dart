import 'package:dio/dio.dart';
import 'package:myapp/features/core/errors/exceptions/conectasti_exception.dart';
import 'package:myapp/features/core/network/conectasti_api_client.dart';
import 'package:myapp/features/home/datasource/integracao/integracao_datasource.dart';
import 'package:myapp/features/home/models/integracao_model.dart';

class IntegracaoDataSourceImpl implements IntegracaoDataSource {
  final ConectaSTIApiClient apiClient;

  IntegracaoDataSourceImpl(this.apiClient);

@override
Future<List<IntegracaoModel>> getIntegracoes({String pesquisa = ''}) async {
  try {
    final queryParameters = <String, dynamic>{};

    if (pesquisa.trim().isNotEmpty) {
      queryParameters[r'$filter'] =
          "contains(tolower(nome), '${pesquisa.trim().toLowerCase()}')";
    }

    final response = await apiClient.dio.get(
      '/api/Integracao',
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((item) => IntegracaoModel.fromJson(item)).toList();
    } else {
      throw ConectastiException(
        'Erro ao buscar integracoes: ${response.statusCode}',
      );
    }
  } on DioException catch (e) {
    throw ConectastiException('Erro ao buscar integracoes: ${e.message}');
  }
}
}
