class Passageiro {
  int? codigo;
  String nome;
  String telefone;
  int? endereco;

  Passageiro({
    this.codigo,
    this.nome = '',
    this.telefone = '',
    this.endereco,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nome': nome,
      'telefone': telefone,
      'endereco_codigo': endereco
    };
  }
}
