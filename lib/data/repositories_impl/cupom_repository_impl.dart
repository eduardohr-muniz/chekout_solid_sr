
import '../../domain/repositories/cupom_repository.dart';
import '../../domain/entities/cupom.dart';
import '../../external/services/cupom_api_service.dart';

class CupomRepositoryImpl implements CupomRepository {
  final CupomApiService api;

  CupomRepositoryImpl(this.api);

  @override
  Future<Cupom?> buscarCupom(String codigo) async {
    final json = await api.buscarCupomNaApi(codigo);
    if (json == null) return null;
    return Cupom(codigo: json['codigo'], desconto: json['desconto']);
  }
}
