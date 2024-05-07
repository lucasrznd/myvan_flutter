import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/viagem/viagem_form.dart';
import 'package:myvan_flutter/components/viagem/viagem_list.dart';
import 'package:myvan_flutter/models/endereco.dart';
import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/viagem.dart';

class ViagemPage extends StatefulWidget {
  const ViagemPage({Key? key}) : super(key: key);

  @override
  State<ViagemPage> createState() => _ViagemPageState();
}

class _ViagemPageState extends State<ViagemPage> {
  List<Viagem> viagens = [];

  void deleteViagem(int codigo) {
    setState(() {
      viagens.removeWhere((viagem) => viagem.codigo == codigo);
    });
  }

  void salvarViagem(BuildContext context, veiculo, motorista, DateTime data,
      TipoViagem tipoViagem, String nomeViagem) {
    final novaViagem = Viagem(
      codigo: Random().nextInt(150),
      veiculo: veiculo,
      motorista: motorista,
      data: data,
      tipoViagem: tipoViagem,
      nomeViagem: nomeViagem,
    );

    setState(() {
      viagens.add(novaViagem);
    });

    Navigator.of(context).pop();

    // Mostra um diálogo informando que a viagem foi salva
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Viagem Salva'),
        content: const Text('A viagem foi salva com sucesso!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void openFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ViagemForm((veiculo, motorista, data, tipoViagem, nomeViagem) =>
            salvarViagem(
                context, veiculo, motorista, data, tipoViagem, nomeViagem));
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
          onPressed: () => openFormModal(context),
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
                viagens,
                deleteViagem,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openFormModal(context),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
