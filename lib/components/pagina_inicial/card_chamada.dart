import 'package:flutter/material.dart';

class CardChamada extends StatelessWidget {
  final String texto;
  const CardChamada({required this.texto, super.key});

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
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              leading: const SizedBox(
                height: 90,
                child: Icon(
                  Icons.how_to_reg_outlined,
                  color: Color.fromARGB(255, 255, 255, 255),
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
