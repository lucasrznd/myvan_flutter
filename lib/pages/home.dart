import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/pagina_inicial/card_menor.dart';
import 'package:myvan_flutter/components/custom_app_bar.dart';
import 'package:myvan_flutter/components/pagina_inicial/card_chamada.dart';
import 'package:myvan_flutter/pages/motorista.dart';
import 'package:myvan_flutter/pages/tela_passageiro.dart';

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
          CardExample(
            texto: 'CHAMADA IDA',
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CardExample(
              texto: 'CHAMADA VOLTA',
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaMotorista(),
                    ),
                  );
                },
                child: CardPequeno(
                  titulo: 'Motorista',
                  imagem: 'assets/app/icone_motorista.png',
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaPassageiro(),
                    ),
                  );
                },
                child: CardPequeno(
                  titulo: 'Passageiros',
                  imagem: 'assets/app/icone_passageiro.png',
                ),
              ),
              const SizedBox(width: 20),
              CardPequeno(
                titulo: 'Viagens',
                imagem: 'assets/app/icone_viagens.png',
              ),
            ],
          ),
        ],
      ),
    );
  }
}