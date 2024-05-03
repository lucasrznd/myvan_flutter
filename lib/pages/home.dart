import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/bottom_navigation/fab_tabs.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/pagina_inicial/card_menor.dart';
import 'package:myvan_flutter/components/custom_app_bar.dart';
import 'package:myvan_flutter/components/pagina_inicial/card_chamada.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: const CustomAppBar(title: 'Home'),
      body: ListView(
        children: [
          SizedBox(
            height: 200,
            child: Image.asset('assets/app/icon.png'),
          ),
          const CardExample(
            texto: 'CHAMADA IDA',
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: CardExample(
              texto: 'CHAMADA VOLTA',
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FabTabs(selectedIndex: 2)))
                },
                child: const CardPequeno(
                  titulo: 'Motorista',
                  imagem: 'assets/app/icone_motorista.png',
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () => {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FabTabs(selectedIndex: 1)))
                },
                child: const CardPequeno(
                  titulo: 'Passageiros',
                  imagem: 'assets/app/icone_passageiro.png',
                ),
              ),
              const SizedBox(width: 20),
              const CardPequeno(
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
