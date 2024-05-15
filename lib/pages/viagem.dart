import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/utils/modal_mensagens.dart';
import 'package:myvan_flutter/components/viagem/viagem_form.dart';
import 'package:myvan_flutter/components/viagem/viagem_list.dart';
import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/models/veiculo.dart';
import 'package:myvan_flutter/models/viagem.dart';
import 'package:myvan_flutter/services/motorista_service.dart';
import 'package:myvan_flutter/services/veiculo_service.dart';
import 'package:myvan_flutter/services/viagem_service.dart';

class ViagemPage extends StatefulWidget {
  const ViagemPage({super.key});

  @override
  State<ViagemPage> createState() => _ViagemPageState();
}

class _ViagemPageState extends State<ViagemPage> {
  late Viagem _viagem;
  late Future<List<Viagem>> _viagens;
  late Motorista _motorista;
  late Veiculo _veiculo;

  late ViagemService _service;

  @override
  void initState() {
    super.initState();
    _service = ViagemService();
    _viagem = Viagem();
    _viagens = selectAll();
    _motorista = Motorista();
    _veiculo = Veiculo();
  }

  Future<List<Viagem>> selectAll() {
    return _service.selectAll();
  }

  Future<List<Motorista>> _listarMotoristas() {
    MotoristaService service = MotoristaService();
    return service.selectAll();
  }

  Future<List<Veiculo>> _listarVeiculos() {
    VeiculoService service = VeiculoService();
    return service.selectAll();
  }

  void _salvarViagem(Viagem viagem, Motorista motorista, Veiculo veiculo) {
    _service.insert(viagem);

    setState(() {
      _viagens = selectAll();
    });

    Navigator.of(context).pop();

    ModalMensagem.modalSucesso(context, 'Viagem', 'a');
  }

  _editarViagem(Viagem viagem, Motorista motorista, Veiculo veiculo) {
    setState(() {
      _motorista = motorista;
      _veiculo = veiculo;
      _openFormModal(context, viagem, _motorista, _veiculo);
    });
    _motorista = Motorista();
    _veiculo = Veiculo();
  }

  void _deleteViagem(int codigo) async {
    var opcao = await ModalMensagem.modalConfirmDelete(context, 'Viagem', 'a');

    if (opcao) {
      await _service.delete(codigo);

      setState(() {
        _viagens = selectAll();
      });
    }
  }

  void _openFormModal(BuildContext context, Viagem viagem, Motorista motorista,
      Veiculo veiculo) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return ViagemForm(viagem, motorista, _listarMotoristas(), veiculo,
            _listarVeiculos(), _salvarViagem);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Viagens'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade300,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () =>
              _openFormModal(context, _viagem, _motorista, _veiculo),
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
              child: ViagemList(
                _viagens,
                _editarViagem,
                _deleteViagem,
                _listarMotoristas,
                _listarVeiculos,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFormModal(context, _viagem, _motorista, _veiculo),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
