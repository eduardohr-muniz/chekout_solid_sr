import '../entities/endereco.dart';
abstract class EnderecoRepository {
  Future<List<Endereco>> buscarEnderecos();
}