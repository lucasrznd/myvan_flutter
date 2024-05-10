import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappService {
  static void abrirConversa(String telefone) async {
    String numeroLimpo = telefone.replaceAll(RegExp(r'[^\d]'), '');

    Uri uri = Uri.parse('https://wa.me/$numeroLimpo');
    if (!await launchUrl(uri)) {
      debugPrint('Não funcionou.');
    }
  }
}
