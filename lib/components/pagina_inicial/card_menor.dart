import 'package:flutter/material.dart';

class CardPequeno extends StatelessWidget {
  final String titulo;
  final String imagem;

  const CardPequeno({required this.titulo, required this.imagem, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: const Color(0xff2a99fe),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagem,
              height: 50, // Defina a altura desejada para a imagem
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
            Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
