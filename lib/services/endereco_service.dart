import 'package:myvan_flutter/models/endereco.dart';
import 'package:myvan_flutter/repositories/endereco_repository.dart';

class EnderecoService {
  final EnderecoRepository repository = EnderecoRepository();

  Future<List<Endereco>> selectAll() {
    return repository.selectAll();
  }

  Future<Endereco> obterUltimo() {
    return repository.obterUltimo();
  }

  Future<void> insert(Endereco endereco) async {
    if (endereco.codigo == null) {
      return await repository.insert(endereco);
    } else {
      return await update(endereco);
    }
  }

  Future<void> update(Endereco endereco) {
    return repository.update(endereco);
  }

  Future<void> delete(int codigo) {
    return repository.delete(codigo);
  }
}