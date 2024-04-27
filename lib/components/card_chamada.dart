import 'package:flutter/material.dart';

void main() => runApp(const CardChamada());

class CardChamada extends StatelessWidget {
  const CardChamada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const CardExample(),
      ),
    );
  }
}

class CardExample extends StatelessWidget {
  const CardExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        height: 100,
        child: Card(
          color: const Color(0xff79cbfd),
          child: Center(
            child: ListTile(
              title: Text(
                'CHAMADA IDA',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              leading: SizedBox(
                width: 60, // Defina o tamanho desejado para o ícone
                height: 60, // Defina o tamanho desejado para o ícone
                child: Image.asset(
                  'assets/app/icone_chamada_branco.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
