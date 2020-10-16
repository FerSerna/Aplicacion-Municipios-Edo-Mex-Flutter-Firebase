import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/ConsultorPages/desplayMunicipio.dart';

class SearchMunicipios extends StatefulWidget {

  @override
  _SearchMunicipios createState() => _SearchMunicipios();
    
  }
  
  class _SearchMunicipios  extends State<SearchMunicipios>{

  String busqueda = "";
  String seleccion = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar Municipios"),centerTitle: true),
      body: 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SizedBox(height:50),
            Image(image: AssetImage('assets/edomex.png')),
            Text('Ingrese su busqueda: ', style: Theme.of(context).textTheme.headline5),
            SizedBox(height:50),
            TextField (
              onSubmitted: (value){busqueda = value;},
              onChanged: (value){busqueda = value;},
              decoration: InputDecoration(hintText: "Introduzca su busqueda..."),
            ),
            SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround ,
              children: [
                RaisedButton(child:Text('Buscar por IGECEM'),onPressed: (){ 
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DesplayMunicipios("1",busqueda),
                    ));
                } ,),
                RaisedButton(child:Text('Buscar por nombre'),onPressed: (){ 
                  //String camel = StringUtils.(busqueda);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DesplayMunicipios("2",busqueda.toUpperCase()),
                    ));
                } ,),
              ],
            ),
          ],),
        ),
    );
  }
}