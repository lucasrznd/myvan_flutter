import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/viagem/viagem_form.dart';
import 'package:myvan_flutter/components/viagem/viagem_list.dart';
import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/viagem.dart';

class ViagemPage extends StatefulWidget {
  const ViagemPage({super.key});

  @override
  State<ViagemPage> createState() => _ViagemPageState();
}

class _ViagemPageState extends State<ViagemPage> {
  late Viagem _viagem;
  List<Viagem> viagens = [];

  @override
  void initState() {
    super.initState();
    _viagem = Viagem();
  }

  void _salvarViagem(Viagem viagem) {
    setState(() {
      viagens.add(viagem);
    });

    Navigator.of(context).pop();

    modalSucesso();
  }

  _editarViagem(Viagem viagem) {
    setState(() {
      _viagem = viagem;
      _openFormModal(context, _viagem);
    });
  }

  _deleteViagem(int codigo) {
    setState(() {
      viagens.removeWhere((viagem) => viagem.codigo == codigo);
    });
  }

  void _openFormModal(BuildContext context, Viagem viagem) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ViagemForm(viagem, _salvarViagem);
      },
    );
  }

  void modalSucesso() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'Viagem salva.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold
          ),
        ),
        content: const Text(
          'A viagem foi salva com sucesso!',
          style: TextStyle(
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
                viagens,
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
