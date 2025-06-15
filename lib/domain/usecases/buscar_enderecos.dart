import '../entities/endereco.dart';
import '../repositories/endereco_repository.dart';

class BuscarEnderecos {
  final EnderecoRepository _enderecoRepository;

  BuscarEnderecos(this._enderecoRepository);

  Future<List<Endereco>> call() async {
    return await _enderecoRepository.buscarEnderecos();
  }
}
