// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_project/widgets/home.dart';
import 'package:mobile_project/widgets/register/register.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showError = false;

  void loginRequest(BuildContext context, String email, String password) async {
    final url = Uri.parse("https://todo-api-service.onrender.com/users/signin");

    try {
      final response = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        print("${response.statusCode}");
        setState(() {
          showError = true;
        });
      }
    } catch (e) {
      print("error: ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Tela de Login'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Center(
                  child: Text(
                    'Bem-vindo ao app de anotações',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: mailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                  ),
                ),
                SizedBox(height: 20.0),
                if (showError) // Exibe o texto de erro se o estado showError for true
                  Center(
                    child: Text(
                      'Email ou senha incorretos.',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepPurple),
                    ),
                    onPressed: () {
                      String mail = mailController.text;
                      String password = passwordController.text;
                      loginRequest(context, mail, password);
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      'Cadastre-se',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100.0),
                Center(
                  child: Text(
                    "Integrantes:\n Luís \n Willian \n João \n Pedro",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
