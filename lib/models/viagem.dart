class Viagem {
  int? codigo;
  String descricao;
  int? veiculo;
  int? motorista;
  String data;
  String tipoViagem;

  Viagem({
    this.codigo,
    this.descricao = '',
    this.veiculo,
    this.motorista,
    this.data = '',
    this.tipoViagem = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'veiculo_codigo': veiculo,
      'motorista_codigo': motorista,
      'data': data,
      'tipo_viagem': tipoViagem
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Viagem &&
          runtimeType == other.runtimeType &&
          codigo == other.codigo &&
          descricao == other.descricao;

  @override
  int get hashCode => codigo.hashCode ^ descricao.hashCode;

  @override
  String toString() {
    return 'Viagem(codigo: $codigo, nome: $descricao, veiculo: $veiculo, motorista: $motorista, data: $data), tipoViagem: $tipoViagem';
  }
}
