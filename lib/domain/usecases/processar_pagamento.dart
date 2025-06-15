import '../repositories/pagamento_repository.dart';
import '../entities/pagamento.dart';

class ProcessarPagamento {
  final PagamentoRepository _pagamentoRepository;

  ProcessarPagamento(this._pagamentoRepository);

  Future<Pagamento> call(String metodo, double valor) async {
    // Single Responsibility: Apenas processa pagamentos
    // Validações básicas
    if (valor <= 0) {
      throw ArgumentError('Valor do pagamento deve ser maior que zero');
    }

    if (metodo.isEmpty) {
      throw ArgumentError('Método de pagamento não pode estar vazio');
    }

    return await _pagamentoRepository.processarPagamento(metodo, valor);
  }
}
