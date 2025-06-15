class CalcularSubtotal {
  double call(List<double> precos) => precos.fold(0, (a, b) => a + b);
}