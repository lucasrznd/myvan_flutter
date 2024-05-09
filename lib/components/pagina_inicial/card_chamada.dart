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
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              leading: SizedBox(
                height: 90,
                child: Icon(
                  Icons.how_to_reg_outlined,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  size: 50,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
