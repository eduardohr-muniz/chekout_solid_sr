import 'package:flutter/material.dart';
import '../../domain/entities/endereco.dart';

class EnderecoSection extends StatelessWidget {
  final Endereco? enderecoSelecionado;
  final List<Endereco> enderecosDisponiveis;
  final bool carregandoEnderecos;
  final Function(Endereco) onEnderecoSelecionado;
  final VoidCallback onBuscarEnderecos;

  const EnderecoSection({super.key, required this.enderecoSelecionado, required this.enderecosDisponiveis, required this.carregandoEnderecos, required this.onEnderecoSelecionado, required this.onBuscarEnderecos});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('📍 Endereço de Entrega', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  onPressed: carregandoEnderecos ? null : onBuscarEnderecos,
                  icon: carregandoEnderecos ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.search),
                  label: Text(carregandoEnderecos ? 'Buscando...' : 'Buscar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (enderecosDisponiveis.isEmpty && !carregandoEnderecos)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.blue[200]!)),
                child: const Text('📍 Clique em "Buscar" para carregar endereços\n(Demonstração do caso de uso BuscarEnderecos)', textAlign: TextAlign.center, style: TextStyle(color: Colors.blue, fontSize: 14)),
              )
            else if (enderecosDisponiveis.isNotEmpty)
              Column(
                children: [
                  ...enderecosDisponiveis.map((endereco) => _buildEnderecoCard(endereco)),

                  if (enderecoSelecionado != null) ...[
                    const Divider(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.green)),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(child: Text('Endereço selecionado: ${enderecoSelecionado!.rua}, ${enderecoSelecionado!.cidade}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnderecoCard(Endereco endereco) {
    final isSelected = enderecoSelecionado == endereco;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: isSelected ? Colors.green[50] : null,
      child: ListTile(
        leading: Icon(Icons.location_on, color: isSelected ? Colors.green : Colors.blue),
        title: Text(endereco.rua, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        subtitle: Text(endereco.cidade),
        trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
        onTap: () => onEnderecoSelecionado(endereco),
      ),
    );
  }
}
