import 'package:flutter/material.dart';

class ModalMensagem {
  static void modalSucesso(
      BuildContext context, objeto, String pronomeObliquo) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          '$objeto salv$pronomeObliquo.',
          style: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        content: Text(
          '$objeto salv$pronomeObliquo com sucesso!',
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.blue.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
