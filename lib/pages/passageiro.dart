import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/passageiro/passageiro_form.dart';
import 'package:myvan_flutter/components/passageiro/passageiro_list.dart';
import 'package:myvan_flutter/components/utils/modal_mensagens.dart';
import 'package:myvan_flutter/models/endereco.dart';
import 'package:myvan_flutter/models/passageiro.dart';
import 'package:myvan_flutter/repositories/endereco_repository.dart';
import 'package:myvan_flutter/repositories/passageiro_repository.dart';

class PassageiroPage extends StatefulWidget {
  const PassageiroPage({super.key});

  @override
  State<PassageiroPage> createState() => _PassageiroPageState();
}

class _PassageiroPageState extends State<PassageiroPage> {
  late Passageiro _passageiro;
  late Endereco _endereco;
  late Future<List<Passageiro>> _passageiros;

  @override
  void initState() {
    super.initState();
    _passageiro = Passageiro();
    _endereco = Endereco();
    _passageiros = listarPassageiros();
  }

  Future<List<Passageiro>> listarPassageiros() async {
    PassageiroRepository repository = PassageiroRepository();
    List<Passageiro> passageiros = await repository.selectAll();
    return passageiros;
  }

  Future<List<Endereco>> _listarEnderecos() async {
    EnderecoRepository repository = EnderecoRepository();
    List<Endereco> enderecos = await repository.selectAll();
    return enderecos;
  }

  Future<Endereco> _salvarEndereco(Endereco endereco) async {
    EnderecoRepository repository = EnderecoRepository();
    if (endereco.codigo == null) {
      await repository.insert(endereco); // Espera a inserção ser concluída
    } else {
      await repository.update(endereco);
    }
    // Obtém o último endereço e espera a resolução do Future
    Endereco ultimoEndereco = await repository.obterUltimo();

    // Retorna o último endereço obtido
    return ultimoEndereco;
  }

  _salvarPassageiro(Passageiro passageiro, Endereco endereco) async {
    Endereco ultimoEndereco = await _salvarEndereco(endereco);
    PassageiroRepository repository = PassageiroRepository();

    passageiro.endereco = ultimoEndereco.codigo;

    repository.insert(passageiro);

    _passageiro = Passageiro();
    _endereco = Endereco();

    setState(() {
      _passageiros = repository.selectAll();
    });

    if (!mounted) return;
    Navigator.of(context).pop();

    ModalMensagem.modalSucesso(context, 'Passageiro', 'o');
  }

  _editarPassageiro(Passageiro passageiro, Endereco endereco) {
    setState(() {
      _endereco = endereco;
      _openFormModal(context, passageiro, _endereco);
    });
    _endereco = Endereco();
  }

  void _deletePassageiro(int codigo) async {
    PassageiroRepository repository = PassageiroRepository();

    bool opcao =
        await ModalMensagem.modalConfirmDelete(context, 'Passageiro', 'o');

    if (opcao) {
      await repository.delete(codigo);

      setState(() {
        _passageiros = repository.selectAll();
      });
    }
  }

  _openFormModal(
      BuildContext context, Passageiro passageiro, Endereco endereco) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return PassageiroForm(_salvarPassageiro, passageiro, endereco);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Passageiros'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade300,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openFormModal(context, _passageiro, _endereco),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const SideMenu(),
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: availableHeight * 0.75,
              child: PassageiroList(
                _passageiros,
                _editarPassageiro,
                _deletePassageiro,
                _listarEnderecos,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFormModal(context, _passageiro, _endereco),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
