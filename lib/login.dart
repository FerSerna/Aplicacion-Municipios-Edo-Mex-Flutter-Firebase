import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  
  Future<void> _createUserEmail() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print('error: $e');
    }
  }

  Future<void> _loginUserEmail() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Inicia Sesión", style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 30),
            TextField(
                onSubmitted: (value) {
                  _email = value;
                },
                onChanged: (value) {
                  _email = value;
                },
                decoration: InputDecoration(hintText: "Introduce tu Email...")),
            SizedBox(height: 10),
            TextField(
                onSubmitted: (value) {
                  _password = value;
                },
                onChanged: (value) {
                  _password = value;
                },
                decoration:
                    InputDecoration(hintText: "Introduce tu Contraseña...")),
            SizedBox(height: 50),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                onPressed: _createUserEmail,
                child: Text('Crear una cuenta'),
              ),
              MaterialButton(
                onPressed: _loginUserEmail,
                child: Text('Inicia Sesión'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
