import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/tipo_veiculo/tp_veiculo_form.dart';
import 'package:myvan_flutter/components/tipo_veiculo/tp_veiculo_list.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';
import 'package:myvan_flutter/repositories/tipo_veiculo_repository.dart';

class TipoVeiculoPage extends StatefulWidget {
  const TipoVeiculoPage({super.key});

  @override
  State<TipoVeiculoPage> createState() => _TipoVeiculoPageState();
}

class _TipoVeiculoPageState extends State<TipoVeiculoPage> {
  late TipoVeiculo tipoVeiculo;
  late Future<List<TipoVeiculo>> _tiposVeiculos;
  late TipoVeiculoRepository repository = TipoVeiculoRepository();

  @override
  void initState() {
    super.initState();
    _tiposVeiculos = repository.selectAll();
  }

  Future<List<TipoVeiculo>> selectAll() async {
    return repository.selectAll();
  }

  void _salvarTipoVeiculo(TipoVeiculo tipoVeiculo) {
    repository.insert(tipoVeiculo);

    setState(() {
      _tiposVeiculos = repository.selectAll();
    });

    Navigator.of(context).pop();
  }

  void _editarTipoVeiculo(TipoVeiculo tipoVeiculo) {
    setState(() {
      _openFormModal(context, tipoVeiculo);
    });
  }

  void _deleteTipoVeiculo(int codigo) async {
    await repository.delete(codigo);

    setState(() {
      _tiposVeiculos = repository.selectAll();
    });
  }

  _openFormModal(BuildContext context, TipoVeiculo tipoVeiculo) {
    showModalBottomSheet(
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
      title: const Text('Tipos de Veiculos'),
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
