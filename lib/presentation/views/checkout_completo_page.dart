import 'package:flutter/material.dart';
import '../viewmodels/checkout_viewmodel.dart';
import '../viewmodels/checkout_completo_viewmodel.dart';
import '../components/carrinho_section.dart';
import '../components/endereco_section.dart';
import '../components/entrega_section.dart';
import '../components/cupom_section.dart';
import '../components/pagamento_section.dart';
import '../components/resumo_section.dart';
import '../../domain/entities/item.dart';
import '../../domain/entities/endereco.dart';
import '../../domain/entities/tipo_entrega.dart';

class CheckoutCompletoPage extends StatefulWidget {
  final CheckoutViewModel checkoutViewModel;

  const CheckoutCompletoPage({super.key, required this.checkoutViewModel});

  @override
  State<CheckoutCompletoPage> createState() => _CheckoutCompletoPageState();
}

class _CheckoutCompletoPageState extends State<CheckoutCompletoPage> {
  late CheckoutCompletoViewModel _viewModel;

  // Controladores para formulários
  final _nomeItemController = TextEditingController();
  final _precoItemController = TextEditingController();
  final _cupomController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = CheckoutCompletoViewModel(widget.checkoutViewModel);
  }

  @override
  void dispose() {
    _nomeItemController.dispose();
    _precoItemController.dispose();
    _cupomController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🎯 POC SOLID - Checkout Completo"), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Componente do Carrinho com ValueListenableBuilder
            ValueListenableBuilder<List<Item>>(
              valueListenable: _viewModel.itens,
              builder: (context, itens, child) {
                return CarrinhoSection(itens: itens, nomeController: _nomeItemController, precoController: _precoItemController, onAdicionarItem: _adicionarItem, onRemoverItem: _removerItem);
              },
            ),

            const SizedBox(height: 20),

            // Componente de Endereço com ValueListenableBuilder
            ValueListenableBuilder<Endereco?>(
              valueListenable: _viewModel.enderecoSelecionado,
              builder: (context, enderecoSelecionado, child) {
                return ValueListenableBuilder<List<Endereco>>(
                  valueListenable: _viewModel.enderecosDisponiveis,
                  builder: (context, enderecosDisponiveis, child) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _viewModel.carregandoEnderecos,
                      builder: (context, carregando, child) {
                        return EnderecoSection(enderecoSelecionado: enderecoSelecionado, enderecosDisponiveis: enderecosDisponiveis, carregandoEnderecos: carregando, onEnderecoSelecionado: _selecionarEndereco, onBuscarEnderecos: _buscarEnderecos);
                      },
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            // Componente de Entrega com ValueListenableBuilder
            ValueListenableBuilder<TipoEntrega>(
              valueListenable: _viewModel.tipoEntrega,
              builder: (context, tipoEntrega, child) {
                return EntregaSection(tipoEntrega: tipoEntrega, onTipoEntregaChanged: _mudarTipoEntrega);
              },
            ),

            const SizedBox(height: 20),

            // Componente de Cupom com ValueListenableBuilder
            ValueListenableBuilder<String?>(
              valueListenable: _viewModel.cupomCodigo,
              builder: (context, cupomCodigo, child) {
                return ValueListenableBuilder<double?>(
                  valueListenable: _viewModel.desconto,
                  builder: (context, desconto, child) {
                    return CupomSection(cupomController: _cupomController, cupomCodigo: cupomCodigo, desconto: desconto, onAplicarCupom: _aplicarCupom);
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            // Componente de Resumo com AnimatedBuilder para cálculos reativos
            AnimatedBuilder(
              animation: _viewModel,
              builder: (context, child) {
                return ResumoSection(subtotal: _viewModel.subtotal, taxaEntrega: _viewModel.taxaEntrega, taxaServico: _viewModel.taxaServico, desconto: _viewModel.desconto.value, total: _viewModel.total);
              },
            ),

            const SizedBox(height: 20),

            // Componente de Pagamento com múltiplos ValueListenableBuilder
            ValueListenableBuilder<bool>(
              valueListenable: _viewModel.processandoCheckout,
              builder: (context, processandoCheckout, child) {
                return ValueListenableBuilder<String?>(
                  valueListenable: _viewModel.pedidoId,
                  builder: (context, pedidoId, child) {
                    return AnimatedBuilder(
                      animation: _viewModel,
                      builder: (context, child) {
                        return PagamentoSection(total: _viewModel.total, processandoCheckout: processandoCheckout, pedidoId: pedidoId, onProcessarCheckout: _processarCheckout, onLimparTudo: _limparTudo, canProcessar: _viewModel.podeProcessarCheckout);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Métodos que delegam para o ViewModel (seguindo padrão MVVM)
  void _adicionarItem() async {
    final nome = _nomeItemController.text.trim();
    final precoText = _precoItemController.text.trim();

    if (nome.isEmpty || precoText.isEmpty) {
      _mostrarSnackBar('Preencha nome e preço do item', Colors.orange);
      return;
    }

    final preco = double.tryParse(precoText);
    if (preco == null || preco <= 0) {
      _mostrarSnackBar('Preço deve ser um número válido maior que zero', Colors.red);
      return;
    }

    try {
      await _viewModel.adicionarItem(nome, preco);
      _nomeItemController.clear();
      _precoItemController.clear();
      _mostrarSnackBar('Item adicionado com sucesso!', Colors.green);
    } catch (e) {
      _mostrarSnackBar('Erro ao adicionar item: $e', Colors.red);
    }
  }

  void _removerItem(int index) {
    _viewModel.removerItem(index);
    _mostrarSnackBar('Item removido', Colors.blue);
  }

  void _selecionarEndereco(Endereco endereco) {
    _viewModel.selecionarEndereco(endereco);
    _mostrarSnackBar('Endereço selecionado: ${endereco.cidade}', Colors.green);
  }

  void _mudarTipoEntrega(TipoEntrega? tipo) {
    _viewModel.mudarTipoEntrega(tipo);
  }

  Future<void> _buscarEnderecos() async {
    try {
      await _viewModel.buscarEnderecos();
      _mostrarSnackBar('Endereços carregados!', Colors.green);
    } catch (e) {
      _mostrarSnackBar('Erro ao buscar endereços: $e', Colors.red);
    }
  }

  Future<void> _aplicarCupom() async {
    final codigo = _cupomController.text.trim();
    if (codigo.isEmpty) {
      _mostrarSnackBar('Digite um código de cupom', Colors.orange);
      return;
    }

    try {
      await _viewModel.aplicarCupom(codigo);
      _mostrarSnackBar('Cupom aplicado! Desconto: R\$${_viewModel.desconto.value?.toStringAsFixed(2)}', Colors.green);
    } catch (e) {
      _mostrarSnackBar('$e', Colors.red);
    }
  }

  Future<void> _processarCheckout() async {
    try {
      await _viewModel.processarCheckout();
      _mostrarSnackBar('Checkout finalizado com sucesso!', Colors.green);
    } catch (e) {
      _mostrarSnackBar('Erro no checkout: $e', Colors.red);
    }
  }

  void _limparTudo() {
    _viewModel.limparTudo();
    _cupomController.clear();
    _mostrarSnackBar('Checkout limpo!', Colors.blue);
  }

  void _mostrarSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: backgroundColor, duration: const Duration(seconds: 2)));
  }
}
