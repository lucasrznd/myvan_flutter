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
    return SizedBox(
      width: 400,
      height: 100,
      child: Card(
        color: const Color(0xff79cbfd),
        child: Column(
          children: <Widget>[
            const ListTile(
              title: Text(
                'Chamada Ida',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: Icon(Icons.album),
            ),
          ],
        ),
      ),
    );
  }
}
