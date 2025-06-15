import '../entities/pagamento.dart';

abstract class PagamentoRepository {
  Future<Pagamento> processarPagamento(String metodo, double valor);
}
