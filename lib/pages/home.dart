import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/card_chamada.dart';
import 'package:myvan_flutter/components/card_menor.dart';
import 'package:myvan_flutter/components/custom_app_bar.dart';
import 'package:myvan_flutter/pages/passageiro.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
                MaterialPageRoute(builder: (context) => const PassageiroPage()),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
