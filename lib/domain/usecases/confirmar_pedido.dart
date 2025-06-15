// confirmar_pedido.dart mockado

import '../repositories/pedido_repository.dart';

class ConfirmarPedido {
  final PedidoRepository pedidoRepository;

  ConfirmarPedido(this.pedidoRepository);

  Future<void> call() async {
    await pedidoRepository.confirmarPedido();
  }
}
