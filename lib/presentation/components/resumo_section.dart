import 'package:flutter/material.dart';

class ResumoSection extends StatelessWidget {
  final double subtotal;
  final double taxaEntrega;
  final double taxaServico;
  final double? desconto;
  final double total;

  const ResumoSection({super.key, required this.subtotal, required this.taxaEntrega, required this.taxaServico, required this.desconto, required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('📊 Resumo do Pedido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Cálculos detalhados
            _buildLinhaResumo('Subtotal', subtotal, color: Colors.grey[700]),

            if (desconto != null && desconto! > 0) _buildLinhaResumo('Desconto', -desconto!, color: Colors.green),

            _buildLinhaResumo('Taxa de Entrega', taxaEntrega, color: Colors.grey[700]),
            _buildLinhaResumo('Taxa de Serviço (10%)', taxaServico, color: Colors.grey[700]),

            const Divider(thickness: 2),

            // Total final
            _buildLinhaResumo('TOTAL', total, color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),

            const SizedBox(height: 16),

            // Informações dos cálculos
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.blue[200]!)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('🧮 Demonstração dos Casos de Uso:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                  const SizedBox(height: 8),
                  _buildInfoCalculo('CalcularSubtotal', 'Soma dos preços dos itens'),
                  _buildInfoCalculo('CalcularTaxaEntrega', 'SP: R\$5,00 | Outras: R\$10,00'),
                  _buildInfoCalculo('CalcularTaxaServico', '10% do subtotal'),
                  if (desconto != null && desconto! > 0) _buildInfoCalculo('AplicarCupom', 'Desconto aplicado'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinhaResumo(String label, double valor, {Color? color, double fontSize = 16, FontWeight fontWeight = FontWeight.normal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color)), Text('R\$${valor.toStringAsFixed(2)}', style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color))],
      ),
    );
  }

  Widget _buildInfoCalculo(String useCase, String descricao) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text('$useCase: ', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 12)),
          Expanded(child: Text(descricao, style: const TextStyle(color: Colors.blue, fontSize: 12))),
        ],
      ),
    );
  }
}
