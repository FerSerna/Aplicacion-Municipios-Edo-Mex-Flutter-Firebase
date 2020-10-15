import 'package:flutter/material.dart';

import 'endsesion.dart';

class ConsultorPage extends StatefulWidget {
  @override
  _ConsultorPageState createState() => _ConsultorPageState();
}

class _ConsultorPageState extends State<ConsultorPage> {
  int _currentIndex = 0;

  final _desplay = [
    Text("Pagina de Consultor"),
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
              title: Text('Consultor Land Page'),
              backgroundColor: Colors.amber[100]),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Cerrar Sesión'),
              backgroundColor: Colors.amber[100]),
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
