class Pagamento {
  final String metodo;
  final double valor;
  final DateTime dataHora;
  final String status;

  Pagamento({required this.metodo, required this.valor, required this.dataHora, this.status = 'pendente'});

  // Método para criar um pagamento aprovado
  Pagamento.aprovado({required this.metodo, required this.valor, required this.dataHora}) : status = 'aprovado';

  // Método para criar um pagamento rejeitado
  Pagamento.rejeitado({required this.metodo, required this.valor, required this.dataHora}) : status = 'rejeitado';
}
