import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/ConsultorPages/desplayMunicipio.dart';

class SearchMunicipios extends StatefulWidget {
  @override
  _SearchMunicipios createState() => _SearchMunicipios();
}

class _SearchMunicipios extends State<SearchMunicipios> {
  String busqueda = "";
  String seleccion = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                title: Text('Buscar'),
                centerTitle: true,
              ),
              TextField(
                onSubmitted: (value) {
                  busqueda = value;
                },
                onChanged: (value) {
                  busqueda = value;
                },
                decoration: InputDecoration(
                    hintText:
                        "Introduzca la busqueda del municipio a editar..."),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    child: Text('Buscar por IGECEM'),
                    color: Colors.orangeAccent,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DesplayMunicipios("1", busqueda),
                      ));
                    },
                  ),
                  RaisedButton(
                    child: Text('Buscar por nombre'),
                    color: Colors.orangeAccent,
                    onPressed: () {
                      //String camel = StringUtils.(busqueda);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DesplayMunicipios("2", busqueda.toUpperCase()),
                      ));
                    },
                  ),
                ],
              ),
              Image(
                image: AssetImage('assets/edomex.jpg'),
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
