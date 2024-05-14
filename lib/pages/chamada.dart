import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/chamada/chamada_form.dart';
import 'package:myvan_flutter/components/chamada/chamada_list.dart';
import 'package:myvan_flutter/components/chamada/dropdown.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/utils/modal_mensagens.dart';
import 'package:myvan_flutter/models/chamada_passageiro.dart';
import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/passageiro.dart';
import 'package:myvan_flutter/models/viagem.dart';
import 'package:myvan_flutter/repositories/chamada_repository.dart';
import 'package:myvan_flutter/repositories/passageiro_repository.dart';
import 'package:myvan_flutter/repositories/viagem_repository.dart';

class ChamadaPage extends StatefulWidget {
  final TipoViagem tipoViagem;
  const ChamadaPage(this.tipoViagem, {super.key});

  @override
  State<ChamadaPage> createState() => _ChamadaPageState();
}

class _ChamadaPageState extends State<ChamadaPage> {
  late List<ChamadaPassageiro> _chamadas;
  late ChamadaPassageiro _chamada;
  late Future<List<Viagem>> _viagens;
  late Future<List<Passageiro>> _passageiros;
  late TipoViagem _tipoViagem;
  late String _tipoBusca;
  bool light = true;

  @override
  void initState() {
    super.initState();
    _chamadas = [];
    _viagens = _listarViagens();
    _passageiros = _listarPassageiros();
    _tipoBusca = 'Todos';
    _tipoViagem = widget.tipoViagem;
    _initializeChamadas();
  }

  void _initializeChamadas() async {
    List<ChamadaPassageiro> chamadas = await selectAll();
    setState(() {
      _chamadas = chamadas;
    });
  }

  void tipoDeBusca() async {
    List<ChamadaPassageiro> chamadas;

    if (_tipoBusca == 'Todos') {
      chamadas = await selectAll();
    } else if (_tipoBusca == 'Presentes') {
      chamadas = await listarPresentes();
    } else {
      chamadas = await listarAusentes();
    }

    setState(() {
      _chamadas = chamadas;
    });
  }

  void listarChamadas() async {
    ChamadaRepository repository = ChamadaRepository();
    List<ChamadaPassageiro> chamadas =
        await repository.selectAllHoje(_tipoViagem.descricao);
    _chamadas = chamadas;
  }

  Future<List<ChamadaPassageiro>> selectAll() async {
    ChamadaRepository repository = ChamadaRepository();

    List<ChamadaPassageiro> chamadas =
        await repository.selectAllHoje(_tipoViagem.descricao);
    return chamadas;
  }

  Future<List<ChamadaPassageiro>> listarPresentes() async {
    ChamadaRepository repository = ChamadaRepository();

    List<ChamadaPassageiro> chamadas =
        await repository.listarPresentesHoje(_tipoViagem.descricao);
    return chamadas;
  }

  Future<List<ChamadaPassageiro>> listarAusentes() async {
    ChamadaRepository repository = ChamadaRepository();

    List<ChamadaPassageiro> chamadas =
        await repository.listarAusentesHoje(_tipoViagem.descricao);
    return chamadas;
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
    ChamadaRepository repository = ChamadaRepository();

    if (chamada.codigo == null) {
      repository.insert(chamada);

      setState(() {
        listarChamadas();
      });

      Navigator.of(context).pop();

      ModalMensagem.modalSucesso(context, 'Chamada', 'a');
    } else {
      repository.update(chamada);
    }
  }

  _editarChamada(ChamadaPassageiro chamada) {
    setState(() {
      _openFormModal(context, chamada);
    });
  }

  _deleteMotorista(int codigo) async {
    ChamadaRepository repository = ChamadaRepository();

    bool opcao =
        await ModalMensagem.modalConfirmDelete(context, 'Passageiro', 'o');

    if (opcao) {
      await repository.delete(codigo);

      setState(() {
        listarChamadas();
      });
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
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      child: ListTile(
                        title: const Text('Ida',
                            style: TextStyle(fontFamily: 'Poppins')),
                        leading: Radio<TipoViagem>(
                          value: TipoViagem.ida,
                          groupValue: _tipoViagem,
                          activeColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue.shade300),
                          onChanged: (TipoViagem? value) {
                            setState(() {
                              _tipoViagem = value!;
                              listarChamadas();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ListTile(
                        title: const Text(
                          'Volta',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        leading: Radio<TipoViagem>(
                          value: TipoViagem.volta,
                          groupValue: _tipoViagem,
                          activeColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue.shade300),
                          onChanged: (TipoViagem? value) {
                            setState(() {
                              _tipoViagem = value!;
                              tipoDeBusca();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 200,
                  height: 60,
                  child: ChamadaDropdown(
                    items: const ['Todos', 'Presentes', 'Ausentes'],
                    hint: 'Selecione uma opção',
                    onChanged: (value) {
                      setState(() {
                        _tipoBusca = value!;
                      });
                      tipoDeBusca();
                    },
                    initialValue: _tipoBusca,
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            SizedBox(
              height: availableHeight * 0.6,
              child: ChamadaList(
                _chamadas,
                _salvarChamada,
                _deleteMotorista,
                _listarViagens,
                _listarPassageiros,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
