import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/tipo_veiculo/tp_veiculo_form.dart';
import 'package:myvan_flutter/components/tipo_veiculo/tp_veiculo_list.dart';
import 'package:myvan_flutter/components/utils/modal_mensagens.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';
import 'package:myvan_flutter/services/tipo_veiculo_service.dart';

class TipoVeiculoPage extends StatefulWidget {
  const TipoVeiculoPage({super.key});

  @override
  State<TipoVeiculoPage> createState() => _TipoVeiculoPageState();
}

class _TipoVeiculoPageState extends State<TipoVeiculoPage> {
  late TipoVeiculo tipoVeiculo;
  late Future<List<TipoVeiculo>> _tiposVeiculos;
  late TipoVeiculoService service;

  @override
  void initState() {
    super.initState();
    service = TipoVeiculoService();
    _tiposVeiculos = selectAll();
  }

  Future<List<TipoVeiculo>> selectAll() {
    return service.selectAll();
  }

  void _salvarTipoVeiculo(TipoVeiculo tipoVeiculo) {
    service.insert(tipoVeiculo);

    setState(() {
      _tiposVeiculos = selectAll();
    });

    Navigator.of(context).pop();

    ModalMensagem.modalSucesso(context, 'Tipo de Veículo', 'o');
  }

  void _editarTipoVeiculo(TipoVeiculo tipoVeiculo) {
    setState(() {
      _openFormModal(context, tipoVeiculo);
    });
  }

  void _deleteTipoVeiculo(int codigo) async {
    bool opcao =
        await ModalMensagem.modalConfirmDelete(context, 'Tipo de Veículo', 'o');

    if (opcao) {
      await service.delete(codigo);

      setState(() {
        _tiposVeiculos = selectAll();
      });
    }
  }

  _openFormModal(BuildContext context, TipoVeiculo tipoVeiculo) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return TipoVeiculoForm(_salvarTipoVeiculo, tipoVeiculo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    tipoVeiculo = TipoVeiculo();

    final appBar = AppBar(
      title: const Text('Tipos de Veículos'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade300,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openFormModal(context, tipoVeiculo),
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
              child: TipoVeiculoList(
                _tiposVeiculos,
                _editarTipoVeiculo,
                _deleteTipoVeiculo,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFormModal(context, tipoVeiculo),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
