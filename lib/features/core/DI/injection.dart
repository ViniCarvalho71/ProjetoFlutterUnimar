import 'package:get_it/get_it.dart';
import 'package:myapp/features/core/network/conectasti_api_client.dart';
import 'package:myapp/features/home/datasource/fluxo/fluxo_datasource.dart';
import 'package:myapp/features/home/datasource/fluxo/fluxo_datasource_impl.dart';
import 'package:myapp/features/home/datasource/integracao/integracao_datasource.dart';
import 'package:myapp/features/home/datasource/integracao/integracao_datasource_impl.dart';
import 'package:myapp/features/home/datasource/log_fluxo/log_fluxo_datasource.dart';
import 'package:myapp/features/home/datasource/log_fluxo/log_fluxo_datasource_impl.dart';
import 'package:myapp/features/home/datasource/rota/rota_datasource.dart';
import 'package:myapp/features/home/datasource/rota/rota_datasource_impl.dart';

final getIt = GetIt.instance;

void setupDependencies() {

  // Injeção de dependência para o ConectaSTIApiClient
  getIt.registerLazySingleton<ConectaSTIApiClient>(
    () => ConectaSTIApiClient(),
  );

  // Injeção de dependência para os DataSources
  getIt.registerLazySingleton<RotaDataSource>(
    () => RotaDataSourceImpl(getIt<ConectaSTIApiClient>()),
  );

  getIt.registerLazySingleton<IntegracaoDataSource>(
    () => IntegracaoDataSourceImpl(getIt<ConectaSTIApiClient>()),
  );

  getIt.registerLazySingleton<FluxoDatasource>(
    () => FluxoDatasourceImpl(getIt<ConectaSTIApiClient>()),
  );

  getIt.registerLazySingleton<LogFluxoDatasource>(
    () => LogFluxoDatasourceImpl(getIt<ConectaSTIApiClient>()),
  );
}