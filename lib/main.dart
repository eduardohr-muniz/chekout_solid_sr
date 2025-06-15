import 'package:flutter/material.dart';
import 'presentation/viewmodels/checkout_viewmodel.dart';
import 'domain/usecases/aplicar_cupom.dart';
import 'domain/usecases/buscar_enderecos.dart';
import 'domain/usecases/calcular_subtotal.dart';
import 'domain/usecases/calcular_taxa_entrega.dart';
import 'domain/usecases/calcular_taxa_servico.dart';
import 'domain/usecases/definir_tipo_entrega.dart';
import 'domain/usecases/processar_pagamento.dart';
import 'domain/usecases/confirmar_pedido.dart';
import 'domain/usecases/validar_carrinho.dart';
import 'domain/usecases/criar_pedido.dart';
import 'domain/usecases/salvar_pedido.dart';
import 'data/repositories_impl/cupom_repository_impl.dart';
import 'data/repositories_impl/endereco_repository_impl.dart';
import 'data/repositories_impl/pagamento_repository_impl.dart';
import 'data/repositories_impl/pedido_repository_impl.dart';
import 'external/services/cupom_api_service.dart';
import 'external/services/endereco_api_service.dart';
import 'external/services/pagamento_api_service.dart';
import 'external/services/pedido_api_service.dart';
import 'presentation/views/checkout_page.dart';

void main() {
  // Instâncias dos serviços externos (camada external)
  final cupomApiService = CupomApiService();
  final enderecoApiService = EnderecoApiService();
  final pagamentoApiService = PagamentoApiService();
  final pedidoApiService = PedidoApiService();

  // Instâncias dos repositórios (camada data)
  final cupomRepository = CupomRepositoryImpl(cupomApiService);
  final enderecoRepository = EnderecoRepositoryImpl(enderecoApiService);
  final pagamentoRepository = PagamentoRepositoryImpl(pagamentoApiService);
  final pedidoRepository = PedidoRepositoryImpl(pedidoApiService);

  // Instâncias dos casos de uso (camada domain)
  final aplicarCupom = AplicarCupom(cupomRepository);
  final buscarEnderecos = BuscarEnderecos(enderecoRepository);
  final calcularSubtotal = CalcularSubtotal();
  final calcularTaxaEntrega = CalcularTaxaEntrega();
  final calcularTaxaServico = CalcularTaxaServico();
  final definirTipoEntrega = DefinirTipoEntrega();
  final processarPagamento = ProcessarPagamento(pagamentoRepository);
  final confirmarPedido = ConfirmarPedido(pedidoRepository);
  final validarCarrinho = ValidarCarrinho();
  final criarPedido = CriarPedido();
  final salvarPedido = SalvarPedido(pedidoRepository);

  // ViewModel que orquestra todos os casos de uso (camada presentation)
  final viewModel = CheckoutViewModel(
    aplicarCupom: aplicarCupom,
    buscarEnderecos: buscarEnderecos,
    calcularSubtotal: calcularSubtotal,
    calcularTaxaEntrega: calcularTaxaEntrega,
    calcularTaxaServico: calcularTaxaServico,
    definirTipoEntrega: definirTipoEntrega,
    processarPagamento: processarPagamento,
    confirmarPedido: confirmarPedido,
    validarCarrinho: validarCarrinho,
    criarPedido: criarPedido,
    salvarPedido: salvarPedido,
  );

  runApp(MaterialApp(title: 'POC SOLID - Checkout', theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true), home: CheckoutPage(viewModel: viewModel)));
}
