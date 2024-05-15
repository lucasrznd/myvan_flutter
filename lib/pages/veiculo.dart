import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/utils/modal_mensagens.dart';
import 'package:myvan_flutter/components/veiculo/veiculo_form.dart';
import 'package:myvan_flutter/components/veiculo/veiculo_list.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';
import 'package:myvan_flutter/models/veiculo.dart';
import 'package:myvan_flutter/services/tipo_veiculo_service.dart';
import 'package:myvan_flutter/services/veiculo_service.dart';

class VeiculoPage extends StatefulWidget {
  const VeiculoPage({super.key});

  @override
  State<VeiculoPage> createState() => _VeiculoPageState();
}

class _VeiculoPageState extends State<VeiculoPage> {
  late Veiculo _veiculo;
  late TipoVeiculo _tipoVeiculo;
  late Future<List<Veiculo>> _veiculos;
  late Future<List<TipoVeiculo>> _tiposVeiculos;

  late VeiculoService _service;
  late TipoVeiculoService _tipoVeiculoService;

  @override
  void initState() {
    super.initState();
    _service = VeiculoService();
    _tipoVeiculoService = TipoVeiculoService();
    _veiculos = listarVeiculos();
    _tiposVeiculos = _listarTiposVeiculos();
    _tipoVeiculo = TipoVeiculo();
  }

  Future<List<Veiculo>> listarVeiculos() {
    return _service.selectAll();
  }

  Future<List<TipoVeiculo>> _listarTiposVeiculos() {
    return _tipoVeiculoService.selectAll();
  }

  _salvarVeiculo(Veiculo veiculo, TipoVeiculo tipoVeiculo) {
    _service.insert(veiculo);

    setState(() {
      _veiculos = listarVeiculos();
    });

    Navigator.of(context).pop();

    ModalMensagem.modalSucesso(context, 'Veiculo', 'o');
  }

  _editarVeiculo(Veiculo veiculo, TipoVeiculo tipoVeiculo) {
    setState(() {
      _openFormModal(context, veiculo, tipoVeiculo);
    });
  }

  void deleteVeiculo(int codigo) async {
    bool opcao =
        await ModalMensagem.modalConfirmDelete(context, 'Veículo', 'o');

    if (opcao) {
      _service.delete(codigo);

      setState(() {
        _veiculos = listarVeiculos();
      });
    }
  }

  _openFormModal(
      BuildContext context, Veiculo veiculo, TipoVeiculo tipoVeiculo) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return VeiculoForm(
            _salvarVeiculo, veiculo, _tiposVeiculos, tipoVeiculo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _veiculo = Veiculo();

    final appBar = AppBar(
      title: const Text('Veículos'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade300,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openFormModal(context, _veiculo, _tipoVeiculo),
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
              child: VeiculoList(
                _veiculos,
                _editarVeiculo,
                deleteVeiculo,
                _listarTiposVeiculos,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFormModal(context, _veiculo, _tipoVeiculo),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
