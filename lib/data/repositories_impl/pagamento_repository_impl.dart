import '../../domain/repositories/pagamento_repository.dart';
import '../../domain/entities/pagamento.dart';
import '../../external/services/pagamento_api_service.dart';

class PagamentoRepositoryImpl implements PagamentoRepository {
  final PagamentoApiService _apiService;

  PagamentoRepositoryImpl(this._apiService);

  @override
  Future<Pagamento> processarPagamento(String metodo, double valor) async {
    // Simulação de chamada para API externa
    print('Processando pagamento de R\$${valor.toStringAsFixed(2)} via $metodo...');
    await Future.delayed(Duration(milliseconds: 500));

    // Simulação de lógica de aprovação (90% de chance de aprovação)
    final aprovado = DateTime.now().millisecond % 10 != 0;
    final dataHora = DateTime.now();

    if (aprovado) {
      print('✅ Pagamento aprovado!');
      return Pagamento.aprovado(metodo: metodo, valor: valor, dataHora: dataHora);
    } else {
      print('❌ Pagamento rejeitado!');
      return Pagamento.rejeitado(metodo: metodo, valor: valor, dataHora: dataHora);
    }
  }
}
