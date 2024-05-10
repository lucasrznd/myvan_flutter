class Veiculo {
  int? codigo;
  int? tipoVeiculo;
  String placa;
  String cor;
  int capacidadePassageiros;

  Veiculo(
      {this.codigo,
      this.tipoVeiculo,
      this.placa = '',
      this.cor = '',
      this.capacidadePassageiros = 4});

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'tipo_veiculo_codigo': tipoVeiculo,
      'placa': placa,
      'cor': cor,
      'capacidade_passageiros': capacidadePassageiros,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Veiculo &&
          runtimeType == other.runtimeType &&
          codigo == other.codigo &&
          placa == other.placa;

  @override
  int get hashCode => codigo.hashCode ^ placa.hashCode;

  @override
  String toString() {
    return 'Veiculo(codigo: $codigo, tipoVeiculo: $tipoVeiculo, placa: $placa, cor: $cor, capacidadePassageiros: $capacidadePassageiros)';
  }
}
