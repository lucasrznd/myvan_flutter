import 'package:flutter/material.dart';
import 'package:myvan_flutter/auth/login.dart';
import 'package:myvan_flutter/components/auth/signup_form.dart';
import 'package:myvan_flutter/components/utils/custom_toast.dart';
import 'package:myvan_flutter/models/usuario.dart';
import 'package:myvan_flutter/services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late Usuario _usuario;
  late AuthService _service;

  @override
  initState() {
    super.initState();
    _usuario = Usuario();
    _service = AuthService();
  }

  signUp() async {
    var result = await _service.signUp(_usuario);

    if (!mounted) return;
    if (result) {
      CustomToast.errorToast(context, 'Nome de usuário já existente.');
    } else {
      CustomToast.showToast(context, 'Usuário criado com sucesso.');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SignUpForm(_usuario, signUp),
        ),
      ),
    );
  }
}
