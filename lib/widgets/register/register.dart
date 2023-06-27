// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_project/widgets/login/login.dart';
import 'package:http/http.dart' as http;

import '../home.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void registerRequest(
      BuildContext context, String name, String email, String password) async {
    String url = "https://todo-api-service.onrender.com/users/signup";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> userData = {
      'name': name,
      'email': email,
      'password': password,
    };

    String jsonBody = json.encode(userData);

    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {}
    } catch (error) {
      print('Erro durante a requisição: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Tela de Cadastro'),
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
                      'Bem-vindo ao TaskGo',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
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
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        String name = nameController.text;
                        String email = mailController.text;
                        String password = passwordController.text;

                        registerRequest(context, name, email, password);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      ),
                      child: SizedBox(
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'Cadastrar',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
