import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/custom_app_bar.dart';
import 'package:myvan_flutter/components/motorista/motorista_form.dart';
import 'package:myvan_flutter/components/motorista/motorista_list.dart';
import 'package:myvan_flutter/models/motorista.dart';

class TelaMotorista extends StatefulWidget {
  const TelaMotorista({super.key});

  @override
  State<TelaMotorista> createState() => _TelaMotoristaState();
}

class _TelaMotoristaState extends State<TelaMotorista> {
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

    print(novoMotorista);
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return MotoristaForm(_salvarMotorista);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = CustomAppBar(title: 'Motoristas');

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _openTransactionFormModal(context),
                  child: Icon(Icons.add),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.blue.shade300,
                      ),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white)),
                ),
              ],
            ),
            Container(
              height: availableHeight * 0.75,
              child: MotoristaList(
                motoristas,
                deleteMotorista,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
