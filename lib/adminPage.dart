import 'package:flutter/material.dart';
import 'package:infoedomex/AdminActions/createMunicipios.dart';
import 'package:infoedomex/AdminActions/listMunicipios.dart';
import 'package:infoedomex/AdminActions/searchMunicipios.dart';
import 'package:infoedomex/AdminActions/searchRiesgos.dart';

import 'endsesion.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _currentIndex = 0;

  final _desplay = [
    ListMunicipios(),
    SearchMunicipios(),
    CreateMunicipio(),
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
              icon: Icon(Icons.home),
              title: Text('Todos'),
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              title: Text('Editar'),
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text('Nuevo'),
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.battery_alert),
              title: Text('Riesgos'),
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.close),
              title: Text('Salir'),
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
