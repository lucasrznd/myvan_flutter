import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/motorista/motorista_form.dart';
import 'package:myvan_flutter/components/motorista/motorista_list.dart';
import 'package:myvan_flutter/models/motorista.dart';

class MotoristaPage extends StatefulWidget {
  const MotoristaPage({super.key});

  @override
  State<MotoristaPage> createState() => _MotoristaPageState();
}

class _MotoristaPageState extends State<MotoristaPage> {
  List<Motorista> motoristas = [];

  deleteMotorista(int codigo) {
    setState(() {
      motoristas.removeWhere((mt) => mt.codigo == codigo);
    });
  }

  _salvarMotorista(String nome, String telefone) {
    final novoMotorista = Motorista(
        codigo: Random().nextInt(150), nome: nome, telefone: telefone);

    setState(() {
      motoristas.add(novoMotorista);
    });

    Navigator.of(context).pop();
  }

  _openFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return MotoristaForm(_salvarMotorista);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Motoristas'),
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
              child: MotoristaList(
                motoristas,
                deleteMotorista,
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
