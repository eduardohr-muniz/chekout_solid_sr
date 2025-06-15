import 'package:flutter/material.dart';

class PagamentoSection extends StatelessWidget {
  final double total;
  final bool processandoCheckout;
  final String? pedidoId;
  final VoidCallback onProcessarCheckout;
  final VoidCallback onLimparTudo;
  final bool canProcessar;

  const PagamentoSection({super.key, required this.total, required this.processandoCheckout, required this.pedidoId, required this.onProcessarCheckout, required this.onLimparTudo, required this.canProcessar});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('💳 Finalizar Pedido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Status do checkout
            if (processandoCheckout) ...[_buildProcessandoStatus()] else if (pedidoId != null) ...[_buildSucessoStatus(pedidoId!)] else ...[_buildFormularioPagamento()],

            const SizedBox(height: 16),

            // Botões de ação
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: canProcessar && !processandoCheckout ? onProcessarCheckout : null,
                    icon: processandoCheckout ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.payment),
                    label: Text(processandoCheckout ? 'Processando...' : 'Finalizar Pedido', style: const TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(backgroundColor: _getBotaoColor(), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: processandoCheckout ? null : onLimparTudo,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Limpar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[600], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormularioPagamento() {
    return Column(
      children: [
        // Total a pagar
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.blue)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('Total a pagar:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)), Text('R\$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue))],
          ),
        ),

        const SizedBox(height: 16),

        // Validações para processar
        if (!canProcessar) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.orange)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('⚠️ Para finalizar o pedido:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                SizedBox(height: 8),
                Text('• Adicione pelo menos um item ao carrinho', style: TextStyle(color: Colors.orange)),
                Text('• Selecione um endereço de entrega', style: TextStyle(color: Colors.orange)),
              ],
            ),
          ),
        ] else ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.green)),
            child: const Text(
              '✅ Pronto para processar!\n'
              'Demonstrará todos os casos de uso SOLID em ação.',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildProcessandoStatus() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.blue)),
      child: const Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('🔄 Processando checkout...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
          SizedBox(height: 8),
          Text(
            'Executando todos os casos de uso:\n'
            'ValidarCarrinho → ProcessarPagamento → CriarPedido → SalvarPedido',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSucessoStatus(String pedidoId) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.green)),
      child: Column(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 48),
          const SizedBox(height: 16),
          const Text('🎉 Pedido realizado com sucesso!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
          const SizedBox(height: 8),
          Text('Pedido #$pedidoId', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green, fontFamily: 'monospace')),
          const SizedBox(height: 12),
          const Text(
            '✅ Todos os princípios SOLID foram demonstrados:\n'
            '• SRP - Responsabilidade única\n'
            '• OCP - Aberto/Fechado\n'
            '• LSP - Substituição de Liskov\n'
            '• ISP - Segregação de Interface\n'
            '• DIP - Inversão de Dependência',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Color _getBotaoColor() {
    if (!canProcessar) return Colors.grey;
    if (processandoCheckout) return Colors.blue;
    if (pedidoId != null) return Colors.green;
    return Colors.blue;
  }
}
