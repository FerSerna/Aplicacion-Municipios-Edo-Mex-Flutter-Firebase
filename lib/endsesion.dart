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
        appBar: AppBar(
          title: Text("Salir"),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(height: 25),
                Image(image: AssetImage('assets/edomex.png')),
                SizedBox(height: 25),
                Text("Creditos:", style: Theme.of(context).textTheme.subtitle2),
                Text("Aldo Daniel Guillermo Martinez",
                    style: Theme.of(context).textTheme.subtitle1),
                Text("Fernanda Ivonne Serna Segura",
                    style: Theme.of(context).textTheme.subtitle1),
                Text("Diego David Garcia Tapia",
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 25),
                Text("Docente:", style: Theme.of(context).textTheme.subtitle2),
                Text("Rocio Elizabeth Pulido Alba",
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 25),
                Text("Materia:", style: Theme.of(context).textTheme.subtitle2),
                Text("Programación Avanzada para el desarrollo",
                    style: Theme.of(context).textTheme.subtitle1),
                Text("de aplicaciones para dispositivos móviles",
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 25),
                MaterialButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: Text("Da clic aquí para cerrar sesión",
                      style: Theme.of(context).textTheme.headline6),
                ),
              ],
            )));
  }
}
