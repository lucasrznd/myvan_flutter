import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/veiculo/veiculo_form.dart';
import 'package:myvan_flutter/components/veiculo/veiculo_list.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';
import 'package:myvan_flutter/models/veiculo.dart';

class VeiculoPage extends StatefulWidget {
  const VeiculoPage({super.key});

  @override
  State<VeiculoPage> createState() => _VeiculoPageState();
}

class _VeiculoPageState extends State<VeiculoPage> {
  final List<Veiculo> _veiculos = [];

  void deleteVeiculo(int codigo) {
    setState(() {
      _veiculos.removeWhere((v) => v.codigo == codigo);
    });
  }

  _salvarVeiculo(String descricao) {
    final novoVeiculo = Veiculo(
        codigo: Random().nextInt(150),
        tipoVeiculo: TipoVeiculo(codigo: 1, descricao: 'tst'),
        cor: 'Branca',
        placa: 'SJG-121',
        capacidadePassageiros: 16);

    setState(() {
      _veiculos.add(novoVeiculo);
    });

    Navigator.of(context).pop();
  }

  _openFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return VeiculoForm(_salvarVeiculo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Veiculos'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade300,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openFormModal(context),
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
              child: VeiculoList(
                _veiculos,
                deleteVeiculo,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFormModal(context),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
