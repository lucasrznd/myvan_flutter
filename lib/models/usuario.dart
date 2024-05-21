class Usuario {
  int? codigo;
  String nomeUsuario;
  String senha;

  Usuario({this.codigo, this.nomeUsuario = '', this.senha = ''});

  Map<String, dynamic> toMap() {
    return {'codigo': codigo, 'nome_usuario': nomeUsuario, 'senha': senha};
  }
}
