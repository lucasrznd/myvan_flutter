import 'package:flutter/material.dart';

void main() => runApp(const CardMenor());

class CardMenor extends StatelessWidget {
  const CardMenor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const CardPequeno(),
      ),
    );
  }
}

class CardPequeno extends StatelessWidget {
  const CardPequeno({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: const Color(0xff79cbfd),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centralizar no eixo vertical
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 50,
              height: 50,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centralizar na horizontal
                children: [
                  Image.asset(
                    'assets/app/icone_chamada.png',
                  ),
                ],
              ),
            ),
            Column(
              children: [Text('data')],
            )
          ],
        ),
      ),
    );
  }
}
