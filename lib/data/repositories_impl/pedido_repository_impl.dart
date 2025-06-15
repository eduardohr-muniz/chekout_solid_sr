import '../../domain/repositories/pedido_repository.dart';
import '../../domain/entities/pedido.dart';
import '../../external/services/pedido_api_service.dart';

class PedidoRepositoryImpl implements PedidoRepository {
  final PedidoApiService _apiService;

  // Simulação de banco de dados em memória
  static final Map<String, Pedido> _pedidos = {};

  PedidoRepositoryImpl(this._apiService);

  @override
  Future<void> confirmarPedido() async {
    // Simulação de chamada para API externa
    print('Enviando pedido para o sistema...');
    await Future.delayed(Duration(milliseconds: 300));
    print('Pedido confirmado com sucesso!');
  }

  @override
  Future<String> salvarPedido(Pedido pedido) async {
    // Simulação de salvamento no banco/API
    print('💾 Salvando pedido #${pedido.id}...');
    await Future.delayed(Duration(milliseconds: 400));

    // Salvar na "base de dados" simulada
    _pedidos[pedido.id] = pedido;

    print('✅ Pedido #${pedido.id} salvo com sucesso!');
    return pedido.id;
  }

  @override
  Future<Pedido?> buscarPedido(String id) async {
    print('🔍 Buscando pedido #$id...');
    await Future.delayed(Duration(milliseconds: 200));

    final pedido = _pedidos[id];
    if (pedido != null) {
      print('✅ Pedido #$id encontrado!');
    } else {
      print('❌ Pedido #$id não encontrado!');
    }

    return pedido;
  }

  @override
  Future<List<Pedido>> listarPedidos() async {
    print('📋 Listando todos os pedidos...');
    await Future.delayed(Duration(milliseconds: 300));

    final pedidos = _pedidos.values.toList();
    print('✅ ${pedidos.length} pedidos encontrados!');

    return pedidos;
  }
}
