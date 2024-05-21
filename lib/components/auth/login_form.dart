import 'package:flutter/material.dart';
import 'package:myvan_flutter/auth/signup.dart';
import 'package:myvan_flutter/models/usuario.dart';

class LoginForm extends StatefulWidget {
  final Usuario _usuario;
  final Function() login;
  const LoginForm(this._usuario, this.login, {super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Image.asset(
              "assets/app/logo_myvan.png",
              width: 330,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withOpacity(.2)),
              child: TextFormField(
                initialValue: widget._usuario.nomeUsuario,
                onChanged: (value) => widget._usuario.nomeUsuario = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nome de Usuário é obrigatório.";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  icon: Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: "Nome de Usuário",
                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withOpacity(.2)),
              child: TextFormField(
                initialValue: widget._usuario.senha,
                onChanged: (value) => widget._usuario.senha = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Senha é obrigatória.";
                  }
                  return null;
                },
                obscureText: !isVisible,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: "Senha",
                  hintStyle: const TextStyle(fontFamily: 'Poppins'),
                  suffixIcon: IconButton(
                    onPressed: () {
                      //In here we will create a click to show and hide the password a toggle button
                      setState(() {
                        //toggle button
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    widget.login();
                  }
                },
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Não tem uma conta?",
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                ),
                TextButton(
                    onPressed: () {
                      //Navigate to sign up
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: const Text(
                      "CADASTRE-SE",
                      style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
