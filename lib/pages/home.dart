import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/card_menor.dart';
import 'package:myvan_flutter/components/custom_app_bar.dart';
import 'package:myvan_flutter/components/card_chamada.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: ListView(
        children: [
          SizedBox(
            height: 200,
            child: Image.asset('assets/app/icon.png'),
          ),
          CardExample(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          CardExample(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardPequeno(titulo: 'Motorista',),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
                CardPequeno(titulo: 'Passageiros',),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
                CardPequeno(titulo: 'Viagens',)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
