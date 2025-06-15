import '../entities/pedido.dart';

abstract class PedidoRepository {
  Future<void> confirmarPedido();
  Future<String> salvarPedido(Pedido pedido);
  Future<Pedido?> buscarPedido(String id);
  Future<List<Pedido>> listarPedidos();
}
