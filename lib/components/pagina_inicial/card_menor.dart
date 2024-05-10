import 'package:flutter/material.dart';

class CardPequeno extends StatelessWidget {
  final String titulo;
  final IconData iconData;

  const CardPequeno({required this.titulo, required this.iconData, super.key});

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
            Icon(
              iconData,
              color: Colors.white,
              size: 50,
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
