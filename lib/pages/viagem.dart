import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/utils/modal_mensagens.dart';
import 'package:myvan_flutter/components/viagem/viagem_form.dart';
import 'package:myvan_flutter/components/viagem/viagem_list.dart';
import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/models/veiculo.dart';
import 'package:myvan_flutter/models/viagem.dart';
import 'package:myvan_flutter/repositories/motorista_repository.dart';
import 'package:myvan_flutter/repositories/veiculo_repository.dart';

class ViagemPage extends StatefulWidget {
  const ViagemPage({super.key});

  @override
  State<ViagemPage> createState() => _ViagemPageState();
}

class _ViagemPageState extends State<ViagemPage> {
  late Viagem _viagem;
  final List<Viagem> _viagens = [];

  @override
  void initState() {
    super.initState();
    _viagem = Viagem();
  }

  Future<List<Motorista>> _listarMotoristas() async {
    MotoristaRepository repository = MotoristaRepository();
    List<Motorista> motoristas = await repository.selectAll();
    return motoristas;
  }

  Future<List<Veiculo>> _listarVeiculos() async {
    VeiculoRepository repository = VeiculoRepository();
    List<Veiculo> veiculos = await repository.selectAll();
    return veiculos;
  }

  void _salvarViagem(Viagem viagem) {
    viagem.data ??= DateTime.now();

    setState(() {
      _viagens.add(viagem);
    });

    Navigator.of(context).pop();

    ModalMensagem.modalSucesso(context, 'Viagem', 'a');
  }

  _editarViagem(Viagem viagem) {
    setState(() {
      _viagem = viagem;
      _openFormModal(context, _viagem);
    });
  }

  _deleteViagem(int codigo) {
    setState(() {
      _viagens.removeWhere((viagem) => viagem.codigo == codigo);
    });
  }

  void _openFormModal(BuildContext context, Viagem viagem) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ViagemForm(
            viagem, _listarMotoristas(), _listarVeiculos(), _salvarViagem);
      },
    );
  }

  void modalSucesso(String objeto, String pronomeObliquo) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          '$objeto salv$pronomeObliquo.',
          style: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        content: Text(
          '$objeto salv$pronomeObliquo com sucesso!',
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.blue.shade300,
              ),
            ),
          ),
        ],
      ),
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
          onPressed: () => _openFormModal(context, _viagem),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
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
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFormModal(context, _viagem),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
