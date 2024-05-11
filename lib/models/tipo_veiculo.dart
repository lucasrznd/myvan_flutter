class TipoVeiculo {
  int? codigo;
  String descricao;

  TipoVeiculo({this.codigo, this.descricao = ''});

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TipoVeiculo &&
          runtimeType == other.runtimeType &&
          codigo == other.codigo &&
          descricao == other.descricao;

  @override
  int get hashCode => codigo.hashCode ^ descricao.hashCode;
}
