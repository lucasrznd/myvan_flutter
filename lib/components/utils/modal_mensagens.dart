import 'dart:async';

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

  static Future<bool> modalConfirmDelete(
      BuildContext context, Object objeto, String pronomeObliquo) async {
    Completer<bool> completer = Completer<bool>();

    Widget cancelButton = ElevatedButton(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.grey),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
      child: const Text(
        'Cancelar',
        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
    );
    Widget continueButton = ElevatedButton(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        backgroundColor: MaterialStateColor.resolveWith(
            (states) => Theme.of(context).colorScheme.error),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
      child: const Text(
        'Confirmar',
        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
    );

    AlertDialog alert = AlertDialog(
      title: const Text(
        'Confirmação',
        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
      content: Text(
        'Deseja remover $pronomeObliquo $objeto selecionad$pronomeObliquo?',
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) {
      // Quando o diálogo é fechado, completar a Future com o valor retornado
      completer.complete(value ?? false); // Se o valor for nulo, retorne false
    });

    // Retorne o futuro que será concluído quando o diálogo for fechado
    return completer.future;
  }
}
