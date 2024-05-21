import 'package:myvan_flutter/models/usuario.dart';
import 'package:myvan_flutter/repositories/usuario_repository.dart';

class AuthService {
  final UsuarioRepository _repository = UsuarioRepository();

  Future<bool> getByNomeUsuario(String nomeUsuario) {
    return _repository.getByNomeUsuario(nomeUsuario);
  }

  Future<bool> login(Usuario usuario) {
    return _repository.login(usuario);
  }

  Future<bool> signUp(Usuario usuario) async {
    bool alreadyExists = await getByNomeUsuario(usuario.nomeUsuario);

    if (alreadyExists) {
      return true;
    }

    _repository.insert(usuario);
    return false;
  }
}
