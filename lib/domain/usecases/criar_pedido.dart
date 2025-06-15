import '../entities/pedido.dart';
import '../entities/item.dart';
import '../entities/cupom.dart';
import '../entities/pagamento.dart';
import '../entities/endereco.dart';
import '../entities/tipo_entrega.dart';

class CriarPedido {
  // Single Responsibility: Apenas cria pedidos com todas as validações

  Future<Pedido> call({required List<Item> itens, required double subtotal, required double taxaEntrega, required double taxaServico, required double total, required TipoEntrega tipoEntrega, Cupom? cupom, required Pagamento pagamento, required Endereco endereco}) async {
    // Validações de negócio
    _validarItens(itens);
    _validarValores(subtotal, taxaEntrega, taxaServico, total);
    _validarPagamento(pagamento);
    _validarEndereco(endereco);

    // Criar pedido usando factory method
    final pedido = Pedido.criar(itens: itens, subtotal: subtotal, taxaEntrega: taxaEntrega, taxaServico: taxaServico, total: total, tipoEntrega: tipoEntrega, cupom: cupom, pagamento: pagamento, endereco: endereco);

    print("✅ Pedido criado com sucesso: #${pedido.id}");
    return pedido;
  }

  void _validarItens(List<Item> itens) {
    if (itens.isEmpty) {
      throw ArgumentError('Pedido deve ter pelo menos um item');
    }

    for (var item in itens) {
      if (item.preco <= 0) {
        throw ArgumentError('Item ${item.nome} tem preço inválido');
      }
    }
  }

  void _validarValores(double subtotal, double taxaEntrega, double taxaServico, double total) {
    if (subtotal <= 0) {
      throw ArgumentError('Subtotal deve ser maior que zero');
    }

    if (taxaEntrega < 0) {
      throw ArgumentError('Taxa de entrega não pode ser negativa');
    }

    if (taxaServico < 0) {
      throw ArgumentError('Taxa de serviço não pode ser negativa');
    }

    if (total <= 0) {
      throw ArgumentError('Total deve ser maior que zero');
    }

    // Validar se o total confere
    final totalCalculado = subtotal + taxaEntrega + taxaServico;
    if ((total - totalCalculado).abs() > 0.01) {
      throw ArgumentError('Total não confere com soma dos componentes');
    }
  }

  void _validarPagamento(Pagamento pagamento) {
    if (pagamento.status != 'aprovado') {
      throw ArgumentError('Pagamento deve estar aprovado para criar pedido');
    }

    if (pagamento.valor <= 0) {
      throw ArgumentError('Valor do pagamento deve ser maior que zero');
    }
  }

  void _validarEndereco(Endereco endereco) {
    if (endereco.rua.isEmpty) {
      throw ArgumentError('Endereço deve ter rua preenchida');
    }

    if (endereco.cidade.isEmpty) {
      throw ArgumentError('Endereço deve ter cidade preenchida');
    }
  }
}
