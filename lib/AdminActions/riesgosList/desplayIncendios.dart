import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/objectsAdmin/incendios.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../desplayMunicipios.dart';

String busqueda;

class DesplayIncendios extends StatefulWidget {
  DesplayIncendios(String s) {
    busqueda = s;
  }

  @override
  _DesplayIncendios createState() => _DesplayIncendios();
}

class _DesplayIncendios extends State<DesplayIncendios> {
  //Inicializacion para busquedas
  List<Incendios> postList = [];
  @override
  void initState() {
    super.initState();

    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Incendios");
    postsRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      postList.clear();
      for (var individualKey in keys) {
        Incendios incendios = Incendios(
          data[individualKey]['claveIGECEM'],
          data[individualKey]['municipio'],
          data[individualKey]['incendios'],
        );
        postList.add(incendios);
      }

      setState(() {
        Alert(
            context: context,
            title: "Municipios con Incendios ",
            desc: postList.length.toString() + ' registrados',
            buttons: []).show();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Con Incendios registrados'),
        centerTitle: true,
      ),
      body: Container(
          //Aqui se deben mostrar las publicaciones
          child: postList.length == 0
              ? Text("No hay incendios")
              : ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (_, index) {
                    return postsUI(
                      postList[index].claveIGECEM,
                      postList[index].municipio,
                      postList[index].incendios,
                    );
                  })),
    );
  }

  Widget postsUI(String claveIGECEM, String municipio, String incendios) {
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
              Text('Total de incendios' + incendios.toString(),
                  style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    claveIGECEM.replaceFirst("clave", "Clave IGECEM: "),
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      // ignore: non_constant_identifier_names
                      String IGECEM = claveIGECEM.replaceFirst("clave", "");
                      print('Municipio');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DesplayMunicipios("1", IGECEM),
                      ));
                    },
                    icon: Icon(
                      Icons.data_usage,
                      color: Colors.orange,
                    ),
                  ),
                  /*
                  IconButton(
                    onPressed: () {
                      
                      print('Se modificará el municipio :' + claveIGECEM);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditPublication(
                          municipio,
                          //incendios,
                          claveIGECEM,
                        ),
                      ));
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                  */
                  IconButton(
                      onPressed: () {
                        String clave = claveIGECEM.replaceAll("clave", "id_incendio");
                        DatabaseReference modifyPost = FirebaseDatabase.instance
                            .reference()
                            .child("Incendios")
                            .child(clave);
                        modifyPost.remove();
                        Alert(
                            context: context,
                            title:
                                "Ha sido eliminados los incendios en $municipio",
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
