import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/motorista/motorista_form.dart';
import 'package:myvan_flutter/components/motorista/motorista_list.dart';
import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/repositories/motorista_repository.dart';

class MotoristaPage extends StatefulWidget {
  const MotoristaPage({super.key});

  @override
  State<MotoristaPage> createState() => _MotoristaPageState();
}

class _MotoristaPageState extends State<MotoristaPage> {
  late Future<List<Motorista>> motoristas;
  late Motorista motorista;
  late MotoristaRepository repository = MotoristaRepository();

  @override
  void initState() {
    super.initState();
    motoristas = selectAll();
  }

  Future<List<Motorista>> selectAll() async {
    return await repository.selectAll();
  }

  _salvarMotorista(Motorista motorista) {
    repository.insert(motorista);

    setState(() {
      motoristas = selectAll();
    });

    Navigator.of(context).pop();
  }

  _editarMotorista(Motorista motorista) {
    setState(() {
      _openFormModal(context, motorista);
    });
  }

  _deleteMotorista(int codigo) async {
    await repository.delete(codigo);
    setState(() {
      motoristas = selectAll();
    });
  }

  _openFormModal(BuildContext context, Motorista motorista) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return MotoristaForm(_salvarMotorista, motorista);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    motorista = Motorista();

    final appBar = AppBar(
      title: const Text('Motoristas'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade300,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openFormModal(context, motorista),
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
              height: availableHeight * 0.6,
              child: MotoristaList(
                motoristas,
                _editarMotorista,
                _deleteMotorista,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFormModal(context, motorista),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
