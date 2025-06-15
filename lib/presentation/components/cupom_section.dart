import 'package:flutter/material.dart';

class CupomSection extends StatelessWidget {
  final TextEditingController cupomController;
  final String? cupomCodigo;
  final double? desconto;
  final VoidCallback onAplicarCupom;

  const CupomSection({super.key, required this.cupomController, required this.cupomCodigo, required this.desconto, required this.onAplicarCupom});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('🎫 Cupom de Desconto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Campo de cupom
            Row(
              children: [
                Expanded(
                  child: TextField(controller: cupomController, decoration: const InputDecoration(labelText: 'Código do cupom', border: OutlineInputBorder(), prefixIcon: Icon(Icons.local_offer), hintText: 'Ex: DESCONTO10'), textCapitalization: TextCapitalization.characters),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: cupomCodigo == null ? onAplicarCupom : null,
                  style: ElevatedButton.styleFrom(backgroundColor: cupomCodigo == null ? Colors.purple : Colors.grey, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
                  child: Text(cupomCodigo == null ? 'Aplicar' : 'Aplicado'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Status do cupom
            if (cupomCodigo != null && desconto != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.green)),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cupom "$cupomCodigo" aplicado com sucesso!', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                          Text('Desconto: R\$${desconto!.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Cupons disponíveis (demonstração)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.purple[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.purple[200]!)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🏷️ Cupons disponíveis:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
                    const SizedBox(height: 8),
                    _buildCupomDisponivel('DESCONTO10', '10% de desconto'),
                    _buildCupomDisponivel('BEMVINDO', '5% para novos clientes'),
                    _buildCupomDisponivel('FRETE50', '50% off na taxa de entrega'),
                    const SizedBox(height: 8),
                    const Text('(Demonstração do caso de uso AplicarCupom)', style: TextStyle(color: Colors.purple, fontSize: 12, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCupomDisponivel(String codigo, String descricao) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.purple[100], borderRadius: BorderRadius.circular(4)),
            child: Text(codigo, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, color: Colors.purple)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(descricao, style: const TextStyle(color: Colors.purple))),
        ],
      ),
    );
  }
}
