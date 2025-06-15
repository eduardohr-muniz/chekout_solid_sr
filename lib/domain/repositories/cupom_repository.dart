import '../entities/cupom.dart';

abstract class CupomRepository {
  Future<Cupom?> buscarCupom(String codigo);
}
