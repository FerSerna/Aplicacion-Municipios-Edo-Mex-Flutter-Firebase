import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CloseSesion extends StatefulWidget {
  @override
  _CloseSesion createState() => _CloseSesion();
}

class _CloseSesion extends State<CloseSesion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
        onPressed: () async {await FirebaseAuth.instance.signOut();},
        child: Text('Cerrar Sesión'),
    )));
  }
}
