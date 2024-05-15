import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/passageiro/passageiro_form.dart';
import 'package:myvan_flutter/components/passageiro/passageiro_list.dart';
import 'package:myvan_flutter/components/utils/modal_mensagens.dart';
import 'package:myvan_flutter/models/endereco.dart';
import 'package:myvan_flutter/models/passageiro.dart';
import 'package:myvan_flutter/services/endereco_service.dart';
import 'package:myvan_flutter/services/passageiro_service.dart';

class PassageiroPage extends StatefulWidget {
  const PassageiroPage({super.key});

  @override
  State<PassageiroPage> createState() => _PassageiroPageState();
}

class _PassageiroPageState extends State<PassageiroPage> {
  late Passageiro _passageiro;
  late Endereco _endereco;
  late Future<List<Passageiro>> _passageiros;

  late PassageiroService _service;
  late EnderecoService _enderecoService;

  @override
  void initState() {
    super.initState();
    _service = PassageiroService();
    _enderecoService = EnderecoService();
    _passageiro = Passageiro();
    _endereco = Endereco();
    _passageiros = _listarPassageiros();
  }

  Future<List<Passageiro>> _listarPassageiros() {
    return _service.selectAll();
  }

  Future<List<Endereco>> _listarEnderecos() {
    return _enderecoService.selectAll();
  }

  _salvarPassageiro(Passageiro passageiro, Endereco endereco) async {
    await _service.insert(passageiro, endereco);

    setState(() {
      _passageiros = _listarPassageiros();
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
    bool opcao =
        await ModalMensagem.modalConfirmDelete(context, 'Passageiro', 'o');

    if (opcao) {
      await _service.delete(codigo);

      setState(() {
        _passageiros = _listarPassageiros();
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
