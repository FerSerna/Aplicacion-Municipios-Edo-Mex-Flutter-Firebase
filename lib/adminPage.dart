import 'package:flutter/material.dart';

import 'endsesion.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _currentIndex = 0;

  final _desplay = [
    Text("Pagina de Administrador"),
    CloseSesion(),
  ];

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      //appBar: AppBar(title:Text('Blog de Tecnología - Usuario')),
      body: _desplay[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Admin LandPage'),
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Cerrar Sesión'),
              backgroundColor: Colors.amber),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
    return scaffold;
  }
}
