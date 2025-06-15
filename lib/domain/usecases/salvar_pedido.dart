import '../entities/pedido.dart';
import '../repositories/pedido_repository.dart';

class SalvarPedido {
  final PedidoRepository _pedidoRepository;

  SalvarPedido(this._pedidoRepository);

  Future<String> call(Pedido pedido) async {
    // Single Responsibility: Apenas salva pedidos

    // Validação básica
    if (pedido.status != 'confirmado') {
      throw ArgumentError('Apenas pedidos confirmados podem ser salvos');
    }

    // Salvar através do repositório
    final pedidoId = await _pedidoRepository.salvarPedido(pedido);

    print("✅ Pedido salvo com ID: $pedidoId");
    return pedidoId;
  }
}
