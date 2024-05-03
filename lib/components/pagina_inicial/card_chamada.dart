import 'package:flutter/material.dart';

void main() => runApp(const CardChamada(texto: "Seu texto aqui"));

class CardChamada extends StatelessWidget {
  final String texto;
  const CardChamada({Key? key, required this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CardExample(texto: texto),
      ),
    );
  }
}

class CardExample extends StatelessWidget {
  final String texto;
  const CardExample({Key? key, required this.texto}) : super(key: key);

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
                texto,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 25,
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
