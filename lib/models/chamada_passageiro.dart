class ChamadaPassageiro {
  int? codigo;
  int? viagem;
  int? passageiro;
  int statusChamada;

  ChamadaPassageiro(
      {this.codigo, this.viagem, this.passageiro, this.statusChamada = 1});

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'viagem_codigo': viagem,
      'passageiro_codigo': passageiro,
      'status_chamada': statusChamada
    };
  }
}
