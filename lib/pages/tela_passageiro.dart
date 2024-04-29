import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/passageiro/passageiro_form.dart';
import 'package:myvan_flutter/components/passageiro/passageiro_lits.dart';
import 'package:myvan_flutter/models/endereco.dart';
import 'package:myvan_flutter/models/passageiro.dart';

class TelaPassageiro extends StatefulWidget {
  const TelaPassageiro({Key? key}) : super(key: key);

  @override
  State<TelaPassageiro> createState() => _TelaPassageiroState();
}

class _TelaPassageiroState extends State<TelaPassageiro> {
  List<Passageiro> passageiros = [];

  void deletePassageiro(int codigo) {
    setState(() {
      passageiros.removeWhere((mt) => mt.codigo == codigo);
    });
  }

  void salvarPassageiro(BuildContext context, String nome, String telefone,
      String rua, String bairro, String numero, String cidade) {
    final novoPassageiro = Passageiro(
      codigo: Random().nextInt(150),
      nome: nome,
      telefone: telefone,
      endereco: Endereco(
        codigo: Random().nextInt(150),
        rua: rua,
        bairro: bairro,
        numero: int.parse(numero),
        cidade: cidade,
      ),
    );

    setState(() {
      passageiros.add(novoPassageiro);
    });

    Navigator.of(context).pop();

    print(novoPassageiro);
  }

  void openFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return PassageiroForm((nome, telefone, rua, bairro, numero, cidade) =>
            salvarPassageiro(
                context, nome, telefone, rua, bairro, numero, cidade));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Passageiros'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade300,
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => openFormModal(context),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: availableHeight * 0.75,
              child: PassageiroList(
                passageiros,
                deletePassageiro,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => openFormModal(context),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
