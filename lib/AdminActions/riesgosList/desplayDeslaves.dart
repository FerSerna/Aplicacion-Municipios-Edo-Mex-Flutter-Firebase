import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/objectsAdmin/deslaves.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../desplayMunicipios.dart';

String busqueda;

class DesplayDeslaves extends StatefulWidget {
  DesplayDeslaves(String s) {
    busqueda = s;
  }

  @override
  _DesplayDeslaves createState() => _DesplayDeslaves();
}

class _DesplayDeslaves extends State<DesplayDeslaves> {
  //Inicializacion para busquedas
  List<Deslaves> postList = [];
  @override
  void initState() {
    super.initState();

    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Deslaves");
    postsRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      postList.clear();
      for (var individualKey in keys) {
        Deslaves deslaves = Deslaves(
          data[individualKey]['claveIGECEM'],
          data[individualKey]['municipio'],
          data[individualKey]['porcentajeSuceptabilidad'],
          data[individualKey]['superficie'],
          data[individualKey]['superficieSuceptible'],
        );
        postList.add(deslaves);
      }

      setState(() {
        Alert(
            context: context,
            title: "Municipios con Deslaves",
            desc: postList.length.toString() + ' registrados',
            buttons: []).show(); //tamaño de lista de posts
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Con peligro de deslave'),
        centerTitle: true,
      ),
      body: Container(
          //Aqui se deben mostrar las publicaciones
          child: postList.length == 0
              ? Text("No hay deslaves")
              : ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (_, index) {
                    return postsUI(
                      postList[index].claveIGECEM,
                      postList[index].municipio,
                      postList[index].porcentajeSuceptabilidad,
                      postList[index].superficie,
                      postList[index].superficieSuseptible,
                    );
                  })),
    );
  }

  Widget postsUI(
      String claveIGECEM,
      String municipio,
      String porcentajeSuceptibilidad,
      String superficie,
      String superficieSuseptible) {
    return Card(
        elevation: 10,
        margin: EdgeInsets.all(10),
        child: Container(
          margin: EdgeInsets.all(14),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage('assets/edomex.jpg'),
                height: 100,
              ),
              SizedBox(height: 10),
              Text(municipio, style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 10),
              Text(
                  'Superficie Suceptible a Deslaves: \n' + superficieSuseptible,
                  style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: 10),
              Text(
                  'Porcentaje Total suceptible: ' +
                      porcentajeSuceptibilidad.toString(),
                  style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "S. Total:" + superficie,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    claveIGECEM.replaceFirst("clave", "Clave IGECEM: "),
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      // ignore: non_constant_identifier_names
                      String IGECEM = claveIGECEM.replaceFirst("clave", "");
                      print('Info de Municipio');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DesplayMunicipios("1", IGECEM),
                      ));
                    },
                    icon: Icon(
                      Icons.data_usage,
                      color: Colors.orange,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        String clave = claveIGECEM.replaceAll("clave", "id_deslv");
                        DatabaseReference modifyPost = FirebaseDatabase.instance
                            .reference()
                            .child("Deslaves")
                            .child(clave);
                        modifyPost.remove();
                        Alert(
                            context: context,
                            title: "Ha sido el deslave en $municipio",
                            buttons: []).show();
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
