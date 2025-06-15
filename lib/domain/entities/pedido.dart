import 'cupom.dart';
import 'endereco.dart';
import 'item.dart';
import 'pagamento.dart';
import 'tipo_entrega.dart';

class Pedido {
  final String id;
  final List<Item> itens;
  final double subtotal;
  final double taxaEntrega;
  final double taxaServico;
  final double total;
  final TipoEntrega tipoEntrega;
  final Cupom? cupom; // Opcional - pode não ter cupom
  final Pagamento pagamento;
  final Endereco endereco;
  final DateTime dataHora;
  final String status;

  Pedido({
    required this.id,
    required this.itens,
    required this.subtotal,
    required this.taxaEntrega,
    required this.taxaServico,
    required this.total,
    required this.tipoEntrega,
    this.cupom, // Opcional
    required this.pagamento,
    required this.endereco,
    required this.dataHora,
    this.status = 'confirmado',
  });

  // Factory constructor para gerar ID automaticamente
  factory Pedido.criar({required List<Item> itens, required double subtotal, required double taxaEntrega, required double taxaServico, required double total, required TipoEntrega tipoEntrega, Cupom? cupom, required Pagamento pagamento, required Endereco endereco}) {
    return Pedido(id: DateTime.now().millisecondsSinceEpoch.toString(), itens: itens, subtotal: subtotal, taxaEntrega: taxaEntrega, taxaServico: taxaServico, total: total, tipoEntrega: tipoEntrega, cupom: cupom, pagamento: pagamento, endereco: endereco, dataHora: DateTime.now());
  }

  // Método para obter resumo do pedido
  String get resumo => """
🧾 PEDIDO #$id
   📅 Data: ${dataHora.toString().substring(0, 19)}
   📊 Status: $status
   🛍️  Itens: ${itens.length}
   💰 Subtotal: R\$${subtotal.toStringAsFixed(2)}
   🚚 Taxa Entrega: R\$${taxaEntrega.toStringAsFixed(2)}
   ⚡ Taxa Serviço: R\$${taxaServico.toStringAsFixed(2)}
   ${cupom != null ? '🎫 Cupom: ${cupom!.codigo}\n' : ''}💳 Total: R\$${total.toStringAsFixed(2)}
   📍 Endereço: ${endereco.rua}, ${endereco.cidade}
   💳 Pagamento: ${pagamento.metodo}
""";
}
