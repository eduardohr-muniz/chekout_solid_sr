import 'package:flutter/material.dart';
import '../../domain/entities/tipo_entrega.dart';

class EntregaSection extends StatelessWidget {
  final TipoEntrega tipoEntrega;
  final Function(TipoEntrega?) onTipoEntregaChanged;

  const EntregaSection({super.key, required this.tipoEntrega, required this.onTipoEntregaChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('🚚 Tipo de Entrega', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Opções de entrega
            ...TipoEntrega.values.map((tipo) => _buildTipoEntregaOption(tipo)),

            const SizedBox(height: 12),

            // Informações adicionais
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.blue[200]!)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('ℹ️ Informações:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)), const SizedBox(height: 8), _buildInfoTexto()]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipoEntregaOption(TipoEntrega tipo) {
    final isSelected = tipoEntrega == tipo;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: isSelected ? Colors.blue[50] : null,
      child: ListTile(
        leading: Icon(_getTipoEntregaIcon(tipo), color: isSelected ? Colors.blue : Colors.grey),
        title: Text(_getTipoEntregaTitulo(tipo), style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        subtitle: Text(_getTipoEntregaDescricao(tipo)),
        trailing: Radio<TipoEntrega>(value: tipo, groupValue: tipoEntrega, onChanged: onTipoEntregaChanged, activeColor: Colors.blue),
        onTap: () => onTipoEntregaChanged(tipo),
      ),
    );
  }

  Widget _buildInfoTexto() {
    switch (tipoEntrega) {
      case TipoEntrega.entrega:
        return const Text(
          '• Taxa de entrega calculada por cidade\n'
          '• SP: R\$5,00 | Outras: R\$10,00\n'
          '• Entrega em 2-3 dias úteis',
          style: TextStyle(color: Colors.blue),
        );
      case TipoEntrega.retirada:
        return const Text(
          '• Sem taxa de entrega\n'
          '• Retire na loja em horário comercial\n'
          '• Disponível em até 2 horas',
          style: TextStyle(color: Colors.blue),
        );
      case TipoEntrega.local:
        return const Text(
          '• Consumo no local\n'
          '• Sem taxa de entrega\n'
          '• Mesa disponível por 2 horas',
          style: TextStyle(color: Colors.blue),
        );
    }
  }

  String _getTipoEntregaTitulo(TipoEntrega tipo) {
    switch (tipo) {
      case TipoEntrega.entrega:
        return 'Entrega (Delivery)';
      case TipoEntrega.retirada:
        return 'Retirada na Loja';
      case TipoEntrega.local:
        return 'Consumo no Local';
    }
  }

  String _getTipoEntregaDescricao(TipoEntrega tipo) {
    switch (tipo) {
      case TipoEntrega.entrega:
        return 'Entregamos no seu endereço';
      case TipoEntrega.retirada:
        return 'Você retira na nossa loja';
      case TipoEntrega.local:
        return 'Consuma aqui mesmo';
    }
  }

  IconData _getTipoEntregaIcon(TipoEntrega tipo) {
    switch (tipo) {
      case TipoEntrega.entrega:
        return Icons.delivery_dining;
      case TipoEntrega.retirada:
        return Icons.store;
      case TipoEntrega.local:
        return Icons.restaurant;
    }
  }
}
