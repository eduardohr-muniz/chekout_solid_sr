# POC SOLID - Sistema de Checkout

Esta é uma Prova de Conceito (POC) que demonstra os princípios SOLID em Flutter/Dart através de um sistema de checkout completo.

## 🎯 Objetivos

Demonstrar os 5 princípios SOLID:
- **S** - Single Responsibility Principle
- **O** - Open/Closed Principle  
- **L** - Liskov Substitution Principle
- **I** - Interface Segregation Principle
- **D** - Dependency Inversion Principle

## 🏗️ Arquitetura

A aplicação segue a Clean Architecture com 4 camadas:

```
lib/
├── external/          # Serviços externos (APIs)
├── data/             # Implementações dos repositórios
├── domain/           # Regras de negócio (entidades, casos de uso, interfaces)
└── presentation/     # UI (ViewModels, Views)
```

### Camadas da Arquitetura

1. **External (Camada mais externa)**
   - Serviços de API externos
   - Implementações concretas de comunicação

2. **Data (Camada de dados)**
   - Implementações dos repositórios
   - Adaptadores de dados

3. **Domain (Camada de domínio)**
   - Entidades de negócio
   - Casos de uso
   - Interfaces dos repositórios

4. **Presentation (Camada de apresentação)**
   - ViewModels
   - Views/Widgets

## 🎯 Princípios SOLID Demonstrados

### 1. Single Responsibility Principle (SRP)
Cada classe tem apenas uma responsabilidade:
- `AplicarCupom` - Apenas aplica cupons de desconto
- `CalcularSubtotal` - Apenas calcula subtotais
- `ProcessarPagamento` - Apenas processa pagamentos

### 2. Open/Closed Principle (OCP)
Classes abertas para extensão, fechadas para modificação:
- Novos tipos de entrega podem ser adicionados sem modificar código existente
- Novos métodos de pagamento podem ser implementados através de interfaces

### 3. Liskov Substitution Principle (LSP)
Implementações podem ser substituídas por suas interfaces:
- `CupomRepositoryImpl` pode ser substituído por qualquer implementação de `CupomRepository`
- Permite testes unitários com mocks

### 4. Interface Segregation Principle (ISP)
Interfaces específicas e coesas:
- `CupomRepository` - Apenas operações relacionadas a cupons
- `PagamentoRepository` - Apenas operações de pagamento
- `EnderecoRepository` - Apenas operações de endereço

### 5. Dependency Inversion Principle (DIP)
Módulos de alto nível não dependem de módulos de baixo nível:
- `CheckoutViewModel` depende de abstrações (casos de uso)
- Casos de uso dependem de interfaces de repositórios
- Repositórios são injetados como dependências

## 🚀 Como Executar

1. Clone o projeto
2. Execute `flutter pub get`
3. Execute `flutter run`
4. Toque no botão "Executar POC Completa"
5. Verifique o console para ver os logs da execução

## 📋 Fluxo da POC

A POC executa um checkout completo demonstrando:

1. **Cálculo de Subtotal** - Soma os preços dos itens
2. **Busca de Endereços** - Simula busca de endereços
3. **Definição de Tipo de Entrega** - Define delivery/retirada
4. **Cálculo de Taxa de Entrega** - Baseado na cidade
5. **Cálculo de Taxa de Serviço** - 10% do subtotal
6. **Aplicação de Cupom** - Desconto no valor
7. **Processamento de Pagamento** - Simula pagamento
8. **Confirmação de Pedido** - Finaliza o pedido

## 🧪 Benefícios da Arquitetura

- **Testabilidade** - Cada camada pode ser testada isoladamente
- **Manutenibilidade** - Mudanças são localizadas
- **Flexibilidade** - Fácil substituição de implementações
- **Escalabilidade** - Novos recursos podem ser adicionados facilmente
- **Reutilização** - Casos de uso podem ser reutilizados

## 📝 Exemplos de Extensibilidade

### Adicionar Novo Método de Pagamento
```dart
class PagamentoPixService implements PagamentoApiService {
  @override
  Future<void> processarPagamento() async {
    // Implementação do PIX
  }
}
```

### Adicionar Novo Tipo de Desconto
```dart
class AplicarDescontoPercentual extends AplicarCupom {
  // Nova lógica de desconto
}
```

### Adicionar Validações
```dart
class ValidarCupom {
  Future<bool> call(String codigo) async {
    // Validar se cupom é válido
  }
}
```

Este projeto demonstra como os princípios SOLID podem ser aplicados em Flutter para criar aplicações robustas, testáveis e extensíveis. 