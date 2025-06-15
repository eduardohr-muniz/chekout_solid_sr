
class CupomApiService {
  Future<Map<String, dynamic>?> buscarCupomNaApi(String codigo) async {
    if (codigo == 'MEUCUPOM') {
      return {'codigo': 'MEUCUPOM', 'desconto': 10.0};
    }
    return null;
  }
}
