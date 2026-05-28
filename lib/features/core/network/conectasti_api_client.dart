import 'package:dio/dio.dart';
import 'package:myapp/features/core/network/api_endpoints.dart';

class ConectaSTIApiClient {
  late final Dio dio;

  ConectaSTIApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.urlBase,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}