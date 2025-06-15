class CalcularTaxaEntrega {
  double call(String cidade) => cidade == 'SP' ? 5.0 : 10.0;
}