import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/card_menor.dart';
import 'package:myvan_flutter/components/custom_app_bar.dart';
import 'package:myvan_flutter/components/card_chamada.dart';
import 'package:myvan_flutter/pages/passageiro.dart'; // Importe a página para a qual você quer navegar

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Home'),
      body: ListView(
        children: [
          SizedBox(
            height: 200,
            child: Image.asset('assets/app/icon.png'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PassageiroPage()), // Substitua OutraPagina() pela sua página de destino
              );
            },
            child: const CardExample(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          const CardExample(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardPequeno(
                  titulo: 'Motorista',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
                CardPequeno(
                  titulo: 'Passageiros',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
                CardPequeno(
                  titulo: 'Viagens',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
