class Motorista {
  int? codigo;
  String nome;
  String telefone;

  Motorista({this.codigo, this.nome = '', this.telefone = ''});

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nome': nome,
      'telefone': telefone,
    };
  }
}
