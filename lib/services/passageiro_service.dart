import 'package:myvan_flutter/models/endereco.dart';
import 'package:myvan_flutter/models/passageiro.dart';
import 'package:myvan_flutter/repositories/passageiro_repository.dart';
import 'package:myvan_flutter/services/endereco_service.dart';

class PassageiroService {
  final PassageiroRepository _repository = PassageiroRepository();
  final EnderecoService _enderecoService = EnderecoService();

  Future<List<Passageiro>> selectAll() {
    return _repository.selectAll();
  }

  Future<void> insert(Passageiro passageiro, Endereco endereco) async {
    _enderecoService.insert(endereco);

    /* Pega o último endereço cadastrado e atribui ao passageiro. */
    Endereco ultimoEndereco = await _enderecoService.obterUltimo();
    passageiro.endereco = ultimoEndereco.codigo;

    return _repository.insert(passageiro);
  }

  Future<void> update(Passageiro passageiro) {
    return _repository.update(passageiro);
  }

  Future<void> delete(int codigo) {
    return _repository.delete(codigo);
  }
}
