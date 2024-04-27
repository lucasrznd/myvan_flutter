import 'package:flutter/material.dart';

class CardPequeno extends StatelessWidget {
  final String titulo;

  CardPequeno({required this.titulo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: const Color(0xff2a99fe),
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
            Padding(padding: EdgeInsets.symmetric(vertical: 3)),
            Column(
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
