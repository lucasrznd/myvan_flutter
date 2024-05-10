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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Motorista &&
          runtimeType == other.runtimeType &&
          codigo == other.codigo &&
          nome == other.nome;

  @override
  int get hashCode => codigo.hashCode ^ nome.hashCode;
}
