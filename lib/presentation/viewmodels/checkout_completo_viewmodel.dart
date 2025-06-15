import 'package:flutter/foundation.dart';
import '../../domain/entities/item.dart';
import '../../domain/entities/endereco.dart';
import '../../domain/entities/tipo_entrega.dart';
import '../viewmodels/checkout_viewmodel.dart';

class CheckoutCompletoViewModel extends ChangeNotifier {
  final CheckoutViewModel _checkoutViewModel;

  // Estados internos usando ValueNotifier para máxima reatividade
  final ValueNotifier<List<Item>> _itens = ValueNotifier([]);
  final ValueNotifier<Endereco?> _enderecoSelecionado = ValueNotifier(null);
  final ValueNotifier<TipoEntrega> _tipoEntrega = ValueNotifier(TipoEntrega.entrega);
  final ValueNotifier<String?> _cupomCodigo = ValueNotifier(null);
  final ValueNotifier<double?> _desconto = ValueNotifier(null);
  final ValueNotifier<bool> _processandoCheckout = ValueNotifier(false);
  final ValueNotifier<String?> _pedidoId = ValueNotifier(null);
  final ValueNotifier<List<Endereco>> _enderecosDisponiveis = ValueNotifier([]);
  final ValueNotifier<bool> _carregandoEnderecos = ValueNotifier(false);

  CheckoutCompletoViewModel(this._checkoutViewModel);

  // Getters para expor ValueNotifiers (seguindo princípio da Responsabilidade Única)
  ValueNotifier<List<Item>> get itens => _itens;
  ValueNotifier<Endereco?> get enderecoSelecionado => _enderecoSelecionado;
  ValueNotifier<TipoEntrega> get tipoEntrega => _tipoEntrega;
  ValueNotifier<String?> get cupomCodigo => _cupomCodigo;
  ValueNotifier<double?> get desconto => _desconto;
  ValueNotifier<bool> get processandoCheckout => _processandoCheckout;
  ValueNotifier<String?> get pedidoId => _pedidoId;
  ValueNotifier<List<Endereco>> get enderecosDisponiveis => _enderecosDisponiveis;
  ValueNotifier<bool> get carregandoEnderecos => _carregandoEnderecos;

  // Getters para cálculos reativos
  double get subtotal => _itens.value.fold(0, (sum, item) => sum + item.preco);
  double get taxaEntrega => _enderecoSelecionado.value?.cidade == 'SP' ? 5.0 : 10.0;
  double get taxaServico => subtotal * 0.1;
  double get total => (subtotal - (_desconto.value ?? 0)) + taxaEntrega + taxaServico;
  bool get podeProcessarCheckout => _itens.value.isNotEmpty && _enderecoSelecionado.value != null && !_processandoCheckout.value;

  // Métodos para manipular itens (SRP - Single Responsibility Principle)
  Future<void> adicionarItem(String nome, double preco) async {
    if (nome.trim().isEmpty || preco <= 0) {
      throw Exception('Nome e preço válidos são obrigatórios');
    }

    final novoItem = Item(nome.trim(), preco);
    final itensAtuais = List<Item>.from(_itens.value);
    itensAtuais.add(novoItem);

    _itens.value = itensAtuais;
    notifyListeners(); // Notifica mudanças nos cálculos
  }

  void removerItem(int index) {
    if (index < 0 || index >= _itens.value.length) return;

    final itensAtuais = List<Item>.from(_itens.value);
    itensAtuais.removeAt(index);
    _itens.value = itensAtuais;

    // Limpar desconto se não há mais itens
    if (_itens.value.isEmpty) {
      _desconto.value = null;
      _cupomCodigo.value = null;
    }

    notifyListeners();
  }

  // Métodos para endereços (SRP)
  Future<void> buscarEnderecos() async {
    _carregandoEnderecos.value = true;

    try {
      final enderecos = await _checkoutViewModel.buscarEnderecos();
      _enderecosDisponiveis.value = enderecos;
    } catch (e) {
      // Fallback com endereços mockados
      _enderecosDisponiveis.value = [Endereco('Rua das Flores, 123', 'SP'), Endereco('Av. Paulista, 456', 'SP'), Endereco('Rua Copacabana, 789', 'RJ')];
    } finally {
      _carregandoEnderecos.value = false;
    }
  }

  void selecionarEndereco(Endereco endereco) {
    _enderecoSelecionado.value = endereco;
    notifyListeners(); // Notifica mudança na taxa de entrega
  }

  // Métodos para entrega (SRP)
  void mudarTipoEntrega(TipoEntrega? tipo) {
    if (tipo != null) {
      _tipoEntrega.value = tipo;
      notifyListeners(); // Pode afetar cálculos futuros
    }
  }

  // Métodos para cupom (SRP)
  Future<void> aplicarCupom(String codigo) async {
    if (codigo.trim().isEmpty) {
      throw Exception('Digite um código de cupom');
    }

    if (_itens.value.isEmpty) {
      throw Exception('Adicione itens ao carrinho primeiro');
    }

    try {
      final totalComDesconto = await _checkoutViewModel.aplicarCupom(codigo.trim(), subtotal);
      final descontoCalculado = subtotal - totalComDesconto;

      _cupomCodigo.value = codigo.trim();
      _desconto.value = descontoCalculado;
      notifyListeners(); // Notifica mudança no total
    } catch (e) {
      throw Exception('Erro ao aplicar cupom: $e');
    }
  }

  // Método principal para checkout (SRP)
  Future<void> processarCheckout() async {
    if (!podeProcessarCheckout) {
      throw Exception('Pré-requisitos não atendidos para checkout');
    }

    _processandoCheckout.value = true;
    _pedidoId.value = null;

    try {
      print("\n🚀 INICIANDO CHECKOUT COMPLETO VIA VIEWMODEL");

      // Executar checkout com demonstração dos casos de uso
      await _executarCheckoutComDemonstracao();

      // Simular ID do pedido
      _pedidoId.value = DateTime.now().millisecondsSinceEpoch.toString();

      print("✅ Checkout finalizado! Pedido #${_pedidoId.value}");
    } catch (e) {
      print("❌ Erro no checkout: $e");
      rethrow;
    } finally {
      _processandoCheckout.value = false;
    }
  }

  Future<void> _executarCheckoutComDemonstracao() async {
    // Demonstração visual dos princípios SOLID em ação
    print("📋 Validando carrinho (Caso de uso: ValidarCarrinho)...");
    await Future.delayed(const Duration(milliseconds: 500));

    print("📍 Validando endereço (Caso de uso: BuscarEnderecos)...");
    await Future.delayed(const Duration(milliseconds: 500));

    print("🚚 Confirmando tipo de entrega (Caso de uso: DefinirTipoEntrega)...");
    await Future.delayed(const Duration(milliseconds: 500));

    print("💰 Calculando valores finais (Casos de uso: CalcularSubtotal, CalcularTaxas)...");
    await Future.delayed(const Duration(milliseconds: 500));

    if (_cupomCodigo.value != null) {
      print("🎫 Processando cupom (Caso de uso: AplicarCupom)...");
      await Future.delayed(const Duration(milliseconds: 500));
    }

    print("💳 Processando pagamento (Caso de uso: ProcessarPagamento)...");
    await Future.delayed(const Duration(milliseconds: 800));

    print("📋 Criando pedido (Caso de uso: CriarPedido)...");
    await Future.delayed(const Duration(milliseconds: 500));

    print("💾 Salvando pedido (Caso de uso: SalvarPedido)...");
    await Future.delayed(const Duration(milliseconds: 600));
  }

  // Método para limpar tudo (SRP)
  void limparTudo() {
    _itens.value = [];
    _enderecoSelecionado.value = null;
    _tipoEntrega.value = TipoEntrega.entrega;
    _cupomCodigo.value = null;
    _desconto.value = null;
    _pedidoId.value = null;
    _processandoCheckout.value = false;
    _enderecosDisponiveis.value = [];

    notifyListeners();
  }

  // Dispose seguindo boas práticas
  @override
  void dispose() {
    _itens.dispose();
    _enderecoSelecionado.dispose();
    _tipoEntrega.dispose();
    _cupomCodigo.dispose();
    _desconto.dispose();
    _processandoCheckout.dispose();
    _pedidoId.dispose();
    _enderecosDisponiveis.dispose();
    _carregandoEnderecos.dispose();
    super.dispose();
  }
}
