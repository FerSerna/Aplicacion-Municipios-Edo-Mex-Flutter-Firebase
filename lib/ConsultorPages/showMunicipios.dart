import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/objectsAdmin/municipios.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ShowMunicipios extends StatefulWidget {
  @override
  _ShowMunicipios createState() => _ShowMunicipios();
}

class _ShowMunicipios extends State<ShowMunicipios> {
  //Definir la lista
  List<Municipios> postList = [];

  //Inicializamos database
  @override
  void initState() {
    super.initState();
    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Municipios");
    postsRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      postList.clear();

      //Llenamos la lista con los posts
      for (var individualKey in keys) {
        Municipios posts = Municipios(
            data[individualKey]['altitud'],
            data[individualKey]['cabecera'],
            data[individualKey]['claveIGECEM'],
            data[individualKey]['clima'],
            data[individualKey]['cuerposAgua'],
            data[individualKey]['elevaciones'],
            data[individualKey]['latitud'],
            data[individualKey]['longitud'],
            data[individualKey]['masExtensos'],
            data[individualKey]['masIndustrializados'],
            data[individualKey]['masPoblados'],
            data[individualKey]['menosExtensos'],
            data[individualKey]['municipio'],
            data[individualKey]['rios'],
            data[individualKey]['significado'],
            data[individualKey]['superficie']);
        postList.add(posts);
      }

      setState(() {
        Alert(
            context: context,
            title: "Municipios registrados",
            desc: postList.length.toString() + ' municipios',
            buttons: []).show(); //tamaño de lista de posts
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado'),
        centerTitle: true,
      ),
      body: Container(
          //Aqui se deben mostrar las publicaciones
          child: postList.length == 0
              ? Text("No hay Municipios")
              : ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (_, index) {
                    if (postList[index].claveIGECEM.toString() !=
                        "claveIGECEM") {
                      return postsUI(
                          postList[index].claveIGECEM,
                          postList[index].municipio,
                          postList[index].cabecera,
                          postList[index].significado,
                          postList[index].altitud,
                          postList[index].superficie,
                          postList[index].clima
                          /*
                        postList[index].cuerposAgua,
                        postList[index].elevaciones,
                        postList[index].masExtensos,
                        postList[index].masIndustrializados,
                        postList[index].masPoblados,
                        postList[index].menosExtensos,
                        postList[index].rios,
                      */
                          );
                    } else {
                      return Container();
                    }
                  })),
    );
  }

  Widget postsUI(String claveIGECEM, String municipio, String cabecera,
      String significado, String altitud, String superficie, String clima) {
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
              Text('IGECEM: ' + claveIGECEM,
                  style: Theme.of(context).textTheme.subtitle2),
              SizedBox(height: 10),
              Text(municipio, style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 2),
              Text('Cabecera: ' + cabecera,
                  style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 10),
              Text(significado, style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: 10),
              Text("Clima: " + clima,
                  style: Theme.of(context).textTheme.subtitle2),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Superficie:" + superficie,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Altitud:" + altitud,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
