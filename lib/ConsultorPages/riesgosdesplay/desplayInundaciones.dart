import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/objects/inundaciones.dart';

import '../desplayMunicipio.dart';

String busqueda;

class DesplayInundaciones extends StatefulWidget {
  DesplayInundaciones(String s) {
    busqueda = s;
  }

  @override
  _DesplayInundaciones createState() => _DesplayInundaciones();
}

class _DesplayInundaciones extends State<DesplayInundaciones> {
  //Inicializacion para busquedas
  List<Inundaciones> postList = [];
  @override
  void initState() {
    super.initState();

    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Inundaciones");
    postsRef.once().then((DataSnapshot snap) {
      //print('Data keys : ${snap.value.keys}');
      //print('Data value : ${snap.value}');
      var keys = snap.value.keys;
      var data = snap.value;
      postList.clear();
      for (var individualKey in keys) {
        Inundaciones inundaciones = Inundaciones(
          data[individualKey]['claveIGECEM'],
          data[individualKey]['municipio'],
          data[individualKey]['porcentajeSuceptabilidad'],
          data[individualKey]['superficie'],
          data[individualKey]['superficieSuceptible'],
        );
        postList.add(inundaciones);
      }

      setState(() {
        print(
            'Largo: ' + postList.length.toString()); //tamaño de lista de posts
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Con peligro de Inundacion'), centerTitle: true,),
      body: 
      Container(//Aqui se deben mostrar las publicaciones
        child: postList.length == 0 ? Text("No hay inundaciones") : ListView.builder(
          itemCount: postList.length,
          itemBuilder: (_,index){
              return postsUI(
                postList[index].claveIGECEM,
                postList[index].municipio,
                postList[index].porcentajeSuceptabilidad,
                postList[index].superficie,
                postList[index].superficieSuseptible,
              );
          })
      ),


      ///CUESTIONES DE ESTETICA
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
      ),
    );
  }

  Widget postsUI(String claveIGECEM, String municipio, String porcentajeSuceptibilidad, String superficie, String superficieSuseptible){
    
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Container(
        margin: EdgeInsets.all(14),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/edomex.png'),height: 100,),
            SizedBox(height:10),
            Text(municipio, style: Theme.of(context).textTheme.headline4),
            SizedBox(height:10),
            Text('Superficie Suceptible a Inundaciones: \n'+superficieSuseptible, style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height:10),
            Text('Porcentaje Total suceptible: '+porcentajeSuceptibilidad.toString(), style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text("S. Total:" + superficie,style: Theme.of(context).textTheme.subtitle2, textAlign: TextAlign.center,),
                  Text(claveIGECEM.replaceFirst("clave", "Clave IGECEM: "),style: Theme.of(context).textTheme.subtitle2, textAlign: TextAlign.center,),
                  IconButton(onPressed:(){
                  String IGECEM = claveIGECEM.replaceFirst("clave", "");
                  print('Info de Municipio');
                   Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DesplayMunicipios("1",IGECEM),
                    ));
                }, icon: Icon(Icons.info),),
              ],
            ),
          ],
        ),
      )
    );
  }

}
