import 'package:flutter/material.dart';
import 'package:myvan_flutter/auth/login.dart';
import 'package:myvan_flutter/models/usuario.dart';

class SignUpForm extends StatefulWidget {
  final Usuario _usuario;
  final Function() signUp;
  const SignUpForm(this._usuario, this.signUp, {super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();
  bool isVisible = false;
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/app/logo_myvan.png",
              width: 330,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
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
            //Password field
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
                    focusedBorder: InputBorder.none,
                    icon: const Icon(Icons.lock),
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
                        icon: Icon(isVisible
                            ? Icons.visibility
                            : Icons.visibility_off))),
              ),
            ),
            //Confirm Password field
            // Now we check whether password matches or not
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withOpacity(.2)),
              child: TextFormField(
                controller: confirmPassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Senha é obrigatória.";
                  } else if (widget._usuario.senha != confirmPassword.text) {
                    return "Senhas não coincidem.";
                  }
                  return null;
                },
                obscureText: !isVisible,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  icon: const Icon(Icons.lock),
                  border: InputBorder.none,
                  hintText: "Confirmar Senha",
                  hintStyle: const TextStyle(fontFamily: 'Poppins'),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
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
            //Login button
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.signUp();
                    }
                  },
                  child: const Text(
                    "CADASTRAR",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Já tem uma conta?",
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                TextButton(
                    onPressed: () {
                      //Navigate to sign up
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
