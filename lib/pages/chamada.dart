import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/chamada/chamada_form.dart';
import 'package:myvan_flutter/components/chamada/chamada_list.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/utils/modal_mensagens.dart';
import 'package:myvan_flutter/models/chamada_passageiro.dart';
import 'package:myvan_flutter/models/passageiro.dart';
import 'package:myvan_flutter/models/viagem.dart';
import 'package:myvan_flutter/repositories/passageiro_repository.dart';
import 'package:myvan_flutter/repositories/viagem_repository.dart';

class ChamadaPage extends StatefulWidget {
  const ChamadaPage({super.key});

  @override
  State<ChamadaPage> createState() => _ChamadaPageState();
}

class _ChamadaPageState extends State<ChamadaPage> {
  late Future<List<ChamadaPassageiro>> _chamadas;
  late ChamadaPassageiro _chamada;
  late Future<List<Viagem>> _viagens;
  late Future<List<Passageiro>> _passageiros;

  @override
  void initState() {
    super.initState();
    _chamadas = Future.value([]);
    _viagens = _listarViagens();
    _passageiros = _listarPassageiros();
  }

  Future<List<Viagem>> _listarViagens() async {
    ViagemRepository repository = ViagemRepository();

    List<Viagem> viagens = await repository.selectAll();
    return viagens;
  }

  Future<List<Passageiro>> _listarPassageiros() async {
    PassageiroRepository repository = PassageiroRepository();

    List<Passageiro> passageiros = await repository.selectAll();
    return passageiros;
  }

  _salvarChamada(ChamadaPassageiro chamada) {
    print(chamada.codigo);
    print(chamada.viagem);
    print(chamada.passageiro);
    print(chamada.statusChamada);

    // setState(() {
    //   motoristas = selectAll();
    // });

    Navigator.of(context).pop();

    ModalMensagem.modalSucesso(context, 'Chamada', 'a');
  }

  _editarChamada(ChamadaPassageiro chamada) {
    setState(() {
      _openFormModal(context, chamada);
    });
  }

  _deleteMotorista(int codigo) async {
    bool opcao =
        await ModalMensagem.modalConfirmDelete(context, 'Motorista', 'o');

    if (opcao) {
      // await repository.delete(codigo);

      // setState(() {
      //   motoristas = selectAll();
      // });
    }
  }

  _openFormModal(BuildContext context, ChamadaPassageiro chamada) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return ChamadaForm(_salvarChamada, chamada, _viagens, _passageiros);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _chamada = ChamadaPassageiro();

    final appBar = AppBar(
      title: const Text('Chamadas'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade300,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openFormModal(context, _chamada),
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
              height: availableHeight * 0.6,
              child: ChamadaList(
                _chamadas,
                _editarChamada,
                _deleteMotorista,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFormModal(context, _chamada),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
