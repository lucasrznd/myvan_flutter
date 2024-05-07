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
}
