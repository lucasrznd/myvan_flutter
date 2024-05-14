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
import 'package:myvan_flutter/repositories/passageiro_repository.dart';
import 'package:myvan_flutter/repositories/viagem_repository.dart';
import 'package:myvan_flutter/services/chamada_service.dart';
import 'package:myvan_flutter/services/viagem_service.dart';

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
  final ChamadaService service = ChamadaService();
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      mostrarModal(context);
    });
  }

  void _initializeChamadas() async {
    List<ChamadaPassageiro> chamadas = await selectAllHoje();
    setState(() {
      _chamadas = chamadas;
    });
  }

  void tipoDeBusca() async {
    List<ChamadaPassageiro> chamadas;

    if (_tipoBusca == 'Todos') {
      chamadas = await selectAllHoje();
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
    List<ChamadaPassageiro> chamadas = await selectAllHoje();
    _chamadas = chamadas;
  }

  Future<List<ChamadaPassageiro>> selectAllHoje() async {
    List<ChamadaPassageiro> chamadas = await service.selectAllHoje(_tipoViagem);
    return chamadas;
  }

  Future<List<ChamadaPassageiro>> selectAll() async {
    List<ChamadaPassageiro> chamadas = await service.selectAll();
    return chamadas;
  }

  Future<List<ChamadaPassageiro>> listarPresentes() async {
    List<ChamadaPassageiro> chamadas =
        await service.listarPresentes(_tipoViagem);
    return chamadas;
  }

  Future<List<ChamadaPassageiro>> listarAusentes() async {
    List<ChamadaPassageiro> chamadas =
        await service.listarAusentes(_tipoViagem);
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

  void importarDaUltimaViagem() async {
    ViagemService service = ViagemService();

    service.importarDaUltimaViagem();
  }

  _salvarChamada(ChamadaPassageiro chamada) {
    bool insert = service.insert(chamada);

    if (insert) {
      setState(() {
        listarChamadas();
      });

      Navigator.of(context).pop();

      ModalMensagem.modalSucesso(context, 'Chamada', 'a');
    }
  }

  // _editarChamada(ChamadaPassageiro chamada) {
  //   setState(() {
  //     _openFormModal(context, chamada);
  //   });
  // }

  _deleteChamadaPassageiro(int codigo) async {
    bool opcao =
        await ModalMensagem.modalConfirmDelete(context, 'Passageiro', 'o');

    if (opcao) {
      service.delete(codigo);

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

  void mostrarModal(BuildContext context) async {
    ViagemService viagemService = ViagemService();
    List<Viagem> viagens = await viagemService.selectAll();

    if (viagens.isNotEmpty) {
      List<ChamadaPassageiro> chamadas = await selectAll();

      if (chamadas.isEmpty) {
        BuildContext dialogContext = context;

        showDialog(
          context: dialogContext,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Nenhuma chamada.',
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'Nenhuma chamada encontrada para a viagem de hoje, gostaria de importar da última viagem?',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey)),
                  child: const Text(
                    'Não',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    importarDaUltimaViagem();
                    setState(() {
                      listarChamadas();
                    });
                  },
                  style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue.shade300)),
                  child: const Text('Sim'),
                ),
              ],
            );
          },
        );
      }
    }
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
                _deleteChamadaPassageiro,
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
