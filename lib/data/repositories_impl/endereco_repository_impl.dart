import '../../domain/repositories/endereco_repository.dart';
import '../../domain/entities/endereco.dart';
import '../../external/services/endereco_api_service.dart';

class EnderecoRepositoryImpl implements EnderecoRepository {
  final EnderecoApiService _apiService;

  EnderecoRepositoryImpl(this._apiService);

  @override
  Future<List<Endereco>> buscarEnderecos() async {
    // Simulação de chamada para API externa
    return [Endereco('Rua 2', 'RJ'), Endereco('Av. Paulista', 'SP')];
  }
}
