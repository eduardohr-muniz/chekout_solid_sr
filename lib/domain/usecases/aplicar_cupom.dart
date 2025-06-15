
import '../repositories/cupom_repository.dart';

class AplicarCupom {
  final CupomRepository repository;

  AplicarCupom(this.repository);

  Future<double> call(String codigo, double subtotal) async {
    final cupom = await repository.buscarCupom(codigo);
    if (cupom == null) return subtotal;
    return subtotal - cupom.desconto;
  }
}
