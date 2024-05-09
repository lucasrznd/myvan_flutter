import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/veiculo/veiculo_form.dart';
import 'package:myvan_flutter/components/veiculo/veiculo_list.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';
import 'package:myvan_flutter/models/veiculo.dart';
import 'package:myvan_flutter/repositories/tipo_veiculo_repository.dart';
import 'package:myvan_flutter/repositories/veiculo_repository.dart';

class VeiculoPage extends StatefulWidget {
  const VeiculoPage({super.key});

  @override
  State<VeiculoPage> createState() => _VeiculoPageState();
}

class _VeiculoPageState extends State<VeiculoPage> {
  late Veiculo veiculo;
  late Future<List<Veiculo>> _veiculos;
  late Future<List<TipoVeiculo>> _tiposVeiculos;

  @override
  void initState() {
    super.initState();
    _veiculos = listarVeiculos();
    _tiposVeiculos = listarTiposVeiculos();
  }

  Future<List<Veiculo>> listarVeiculos() async {
    VeiculoRepository repository = VeiculoRepository();
    List<Veiculo> veiculos = await repository.selectAll();
    return veiculos;
  }

  Future<List<TipoVeiculo>> listarTiposVeiculos() async {
    TipoVeiculoRepository tipoVeiculoRepository = TipoVeiculoRepository();
    List<TipoVeiculo> tiposVeiculos = await tipoVeiculoRepository.selectAll();
    return tiposVeiculos;
  }

  _salvarVeiculo(Veiculo veiculo) {
    VeiculoRepository repository = VeiculoRepository();
    repository.insert(veiculo);

    setState(() {
      _veiculos = repository.selectAll();
    });

    Navigator.of(context).pop();
  }

  _editarVeiculo(Veiculo veiculo) {
    setState(() {
      _openFormModal(context, veiculo);
    });
  }

  void deleteVeiculo(int codigo) {
    VeiculoRepository repository = VeiculoRepository();
    repository.delete(codigo);

    setState(() {
      _veiculos = repository.selectAll();
    });
  }

  _openFormModal(BuildContext context, Veiculo veiculo) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return VeiculoForm(_salvarVeiculo, veiculo, _tiposVeiculos);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    veiculo = Veiculo();

    final appBar = AppBar(
      title: const Text('Veículos'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade300,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openFormModal(context, veiculo),
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
                _editarVeiculo,
                deleteVeiculo,
                listarTiposVeiculos,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFormModal(context, veiculo),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
