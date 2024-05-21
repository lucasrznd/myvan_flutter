import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/auth/login_form.dart';
import 'package:myvan_flutter/components/bottom_navigation/fab_tabs.dart';
import 'package:myvan_flutter/components/utils/custom_toast.dart';
import 'package:myvan_flutter/models/usuario.dart';
import 'package:myvan_flutter/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Usuario _usuario;
  late AuthService _service;

  //A bool variable for show and hide password
  bool isVisible = false;
  //Here is our bool variable
  bool isLoginTrue = false;

  @override
  void initState() {
    super.initState();
    _usuario = Usuario();
    _service = AuthService();
  }

  void login() async {
    var response = await _service.login(_usuario);
    if (response == true) {
      if (!mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const FabTabs(selectedIndex: 0)));
      CustomToast.showToast(
          context, 'Bem vindo, ${_usuario.nomeUsuario.toUpperCase()}');
    } else {
      if (!mounted) return;
      CustomToast.errorToast(context, 'Nome de Usuário ou senha incorretos.');
    }
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: LoginForm(_usuario, login),
        ),
      ),
    );
  }
}
