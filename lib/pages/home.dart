import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/bottom_navigation/fab_tabs.dart';
import 'package:myvan_flutter/components/drawer/sidemenu.dart';
import 'package:myvan_flutter/components/custom_app_bar.dart';
import 'package:myvan_flutter/components/pagina_inicial/card_menor.dart';
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
          const Padding(padding: EdgeInsets.symmetric(vertical: 35)),
          SizedBox(
            height: 115,
            child: Image.asset('assets/app/logo_myvan.png'),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FabTabs(selectedIndex: 1),
                ),
              );
            },
            child: const CardChamada(
              texto: 'CHAMADA IDA',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FabTabs(selectedIndex: 1),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: CardChamada(
                texto: 'CHAMADA VOLTA',
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FabTabs(selectedIndex: 3),
                    ),
                  );
                },
                child: const CardPequeno(
                  titulo: 'Motorista',
                  iconData: Icons.person_pin_circle_rounded,
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FabTabs(selectedIndex: 2),
                    ),
                  );
                },
                child: const CardPequeno(
                  titulo: 'Passageiros',
                  iconData: Icons.people_alt,
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FabTabs(selectedIndex: 1),
                    ),
                  );
                },
                child: const CardPequeno(
                  titulo: 'Viagens',
                  iconData: Icons.assistant_direction_rounded,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
