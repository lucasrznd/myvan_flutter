class Endereco {
  int? codigo;
  String rua;
  String bairro;
  int? numero;
  String cidade;

  Endereco({
    this.codigo,
    this.rua = '',
    this.bairro = '',
    this.numero,
    this.cidade = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'rua': rua,
      'bairro': bairro,
      'numero': numero,
      'cidade': cidade
    };
  }
}
