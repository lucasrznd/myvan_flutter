import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/tipo_veiculo/tp_veiculo_form.dart';
import 'package:myvan_flutter/components/tipo_veiculo/tp_veiculo_list.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';

class TipoVeiculoPage extends StatefulWidget {
  const TipoVeiculoPage({super.key});

  @override
  State<TipoVeiculoPage> createState() => _TipoVeiculoPageState();
}

class _TipoVeiculoPageState extends State<TipoVeiculoPage> {
  final List<TipoVeiculo> _tiposVeiculos = [];

  void deleteTipoVeiculo(int codigo) {
    setState(() {
      _tiposVeiculos.removeWhere((mt) => mt.codigo == codigo);
    });
  }

  _salvarTipoVeiculo(String descricao) {
    final novoTipoVeiculo =
        TipoVeiculo(codigo: Random().nextInt(150), descricao: descricao);

    setState(() {
      _tiposVeiculos.add(novoTipoVeiculo);
    });

    Navigator.of(context).pop();
  }

  _openFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TipoVeiculoForm(_salvarTipoVeiculo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Tipos de Veiculos'),
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
              child: TipoVeiculoList(
                _tiposVeiculos,
                deleteTipoVeiculo,
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
