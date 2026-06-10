import 'package:dio/dio.dart';
import 'package:myapp/features/core/errors/exceptions/conectasti_exception.dart';
import 'package:myapp/features/core/network/conectasti_api_client.dart';
import 'package:myapp/features/home/datasource/rota/rota_datasource.dart';
import 'package:myapp/features/home/models/rotas.dart';

class RotaDataSourceImpl implements RotaDataSource {
  final ConectaSTIApiClient apiClient;

  RotaDataSourceImpl(this.apiClient);

@override
Future<List<Rotas>> getRotas({String pesquisa = ''}) async {
  try {
    final queryParameters = <String, dynamic>{};

    if (pesquisa.trim().isNotEmpty) {
      queryParameters[r'$filter'] =
          "contains(tolower(nome), '${pesquisa.trim().toLowerCase()}')";
    }

    final response = await apiClient.dio.get(
      '/api/Rota',
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((item) => Rotas.fromMap(item)).toList();
    } else {
      throw ConectastiException(
        'Erro ao buscar rotas: ${response.statusCode}',
      );
    }
  } on DioException catch (e) {
    throw ConectastiException('Erro ao buscar rotas: ${e.message}');
  }
}
}
