import 'package:myvan_flutter/models/usuario.dart';
import 'package:myvan_flutter/repositories/usuario_repository.dart';

class AuthService {
  final UsuarioRepository _repository = UsuarioRepository();

  Future<bool> login(Usuario usuario) {
    return _repository.login(usuario);
  }

  Future<void> signUp(Usuario usuario) {
    return _repository.insert(usuario);
  }
}
