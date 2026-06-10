import 'package:myapp/features/home/models/rotas.dart';

abstract class RotaDataSource {
  Future<List<Rotas>> getRotas({String pesquisa = ''});
}