import '../entities/carrinho.dart';

class ValidarCarrinho {
  bool call(Carrinho carrinho) {
    // Single Responsibility: Apenas valida o carrinho

    // Validações básicas
    if (carrinho.itens.isEmpty) {
      print("❌ Erro: Carrinho vazio!");
      return false;
    }

    if (carrinho.subtotal <= 0) {
      print("❌ Erro: Subtotal inválido!");
      return false;
    }

    // Validação de valor mínimo
    const double valorMinimo = 15.0;
    if (carrinho.subtotal < valorMinimo) {
      print("❌ Erro: Valor mínimo de pedido é R\$${valorMinimo.toStringAsFixed(2)}");
      return false;
    }

    // Validação de quantidade máxima de itens
    const int maxItens = 50;
    if (carrinho.itens.length > maxItens) {
      print("❌ Erro: Máximo de $maxItens itens por pedido");
      return false;
    }

    print("✅ Carrinho válido: ${carrinho.itens.length} itens, R\$${carrinho.subtotal.toStringAsFixed(2)}");
    return true;
  }
}
