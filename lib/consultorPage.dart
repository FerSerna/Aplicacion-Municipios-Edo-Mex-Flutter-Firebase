import 'package:flutter/material.dart';
import 'package:infoedomex/ConsultorPages/searchMunicipios.dart';
import 'package:infoedomex/ConsultorPages/searchRiesgos.dart';
import 'package:infoedomex/ConsultorPages/showMunicipios.dart';

import 'endsesion.dart';

class ConsultorPage extends StatefulWidget {
  @override
  _ConsultorPageState createState() => _ConsultorPageState();
}

class _ConsultorPageState extends State<ConsultorPage> {
  int _currentIndex = 2;

  final _desplay = [
    ShowMunicipios(),
    SearchMunicipios(),
    SearchRiesgos(),
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
              icon: Icon(Icons.all_out),
              title: Text('Todos'),
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Municipios'),
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.battery_alert),
              title: Text('Riesgos'),
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.close),
              title: Text('Cerrar Sesion'),
              backgroundColor: Colors.orange),
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
