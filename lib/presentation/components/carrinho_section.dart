import 'package:flutter/material.dart';
import '../../domain/entities/item.dart';

class CarrinhoSection extends StatelessWidget {
  final List<Item> itens;
  final TextEditingController nomeController;
  final TextEditingController precoController;
  final VoidCallback onAdicionarItem;
  final Function(int) onRemoverItem;

  const CarrinhoSection({super.key, required this.itens, required this.nomeController, required this.precoController, required this.onAdicionarItem, required this.onRemoverItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('🛍️ Carrinho de Compras', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Formulário para adicionar itens
            Row(
              children: [
                Expanded(flex: 2, child: TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome do produto', border: OutlineInputBorder(), prefixIcon: Icon(Icons.shopping_bag)))),
                const SizedBox(width: 8),
                Expanded(child: TextField(controller: precoController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Preço', border: OutlineInputBorder(), prefixIcon: Icon(Icons.attach_money)))),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: onAdicionarItem, style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white), child: const Icon(Icons.add)),
              ],
            ),

            const SizedBox(height: 16),

            // Lista de itens
            if (itens.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey[300]!)),
                child: const Text('🛒 Carrinho vazio\nAdicione produtos para começar', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 16)),
              )
            else
              Column(
                children: [
                  ...itens.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return _buildItemCard(item, index);
                  }),

                  const Divider(),

                  // Total de itens
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${itens.length} ${itens.length == 1 ? 'item' : 'itens'}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Subtotal: R\$${_calcularSubtotal().toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(Item item, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.blue, child: Text('${index + 1}', style: const TextStyle(color: Colors.white))),
        title: Text(item.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('R\$${item.preco.toStringAsFixed(2)}'),
        trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => onRemoverItem(index)),
      ),
    );
  }

  double _calcularSubtotal() {
    return itens.fold(0, (sum, item) => sum + item.preco);
  }
}
