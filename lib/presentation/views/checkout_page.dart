import 'package:flutter/material.dart';
import '../viewmodels/checkout_viewmodel.dart';

class CheckoutPage extends StatelessWidget {
  final CheckoutViewModel viewModel;

  const CheckoutPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("POC SOLID - Checkout"), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Demonstração dos Princípios SOLID", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 20),

            const Text("Esta POC demonstra:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            const Text("• Single Responsibility: Cada classe tem uma única responsabilidade"),
            const Text("• Open/Closed: Extensível sem modificar o código existente"),
            const Text("• Liskov Substitution: Interfaces podem ser substituídas"),
            const Text("• Interface Segregation: Interfaces específicas"),
            const Text("• Dependency Inversion: Depende de abstrações"),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                print("Executando POC SOLID...");
                await viewModel.executarCheckoutCompleto();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15)),
              child: const Text("Executar POC Completa", style: TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                print("Testando métodos de pagamento...");
                await viewModel.testarMetodosPagamento(50.0);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15)),
              child: const Text("Testar Métodos de Pagamento", style: TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 20),

            TextField(onChanged: (codigo) => viewModel.confirmarCheckout(codigo, 100.0), decoration: const InputDecoration(labelText: 'Teste Cupom de Desconto', border: OutlineInputBorder(), hintText: 'Digite um código de cupom')),

            const SizedBox(height: 20),

            const Expanded(
              child: SingleChildScrollView(
                child: Text(
                  "Verifique o console para ver os logs da execução da POC.\n\n"
                  "Arquitetura utilizada:\n"
                  "• External: Serviços externos (APIs)\n"
                  "• Data: Implementações dos repositórios\n"
                  "• Domain: Entidades, casos de uso e interfaces\n"
                  "• Presentation: ViewModels e Views\n\n"
                  "Cada camada depende apenas de abstrações das camadas internas.",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
