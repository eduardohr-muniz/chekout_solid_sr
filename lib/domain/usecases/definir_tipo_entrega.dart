import '../entities/tipo_entrega.dart';
class DefinirTipoEntrega {
  TipoEntrega tipo = TipoEntrega.entrega;
  void call(TipoEntrega novo) => tipo = novo;
}