import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/passageiro/passageiro_form.dart';
import 'package:myvan_flutter/components/passageiro/passageiro_list.dart';
import 'package:myvan_flutter/models/endereco.dart';
import 'package:myvan_flutter/models/passageiro.dart';

class PassageiroPage extends StatefulWidget {
  const PassageiroPage({super.key});

  @override
  State<PassageiroPage> createState() => _PassageiroPageState();
}

class _PassageiroPageState extends State<PassageiroPage> {
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
      title: const Text('Passageiros'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade300,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => openFormModal(context),
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
              child: PassageiroList(
                passageiros,
                deletePassageiro,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openFormModal(context),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
