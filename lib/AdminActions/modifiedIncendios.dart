import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/objectsAdmin/incendios.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ModifiedIncendios extends StatefulWidget {
  @override
  _ModifiedIncendios createState() => _ModifiedIncendios();
}

class _ModifiedIncendios extends State<ModifiedIncendios> {
  List<Incendios> postList = [];

  //Inicializamos database para jalar los posts
  @override
  void initState() {
    super.initState();
    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Incendios");
    postsRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      postList.clear();

      //Llenamos la lista con los posts
      for (var individualKey in keys) {
        Incendios incendios = Incendios(
          data[individualKey]['claveIGECEM'],
          data[individualKey]['incendios'],
          data[individualKey]['municipio'],
        );
        postList.add(incendios);
      }

      setState(() {
        //print('Largo: $postList.lenght'); //tamaño de lista de posts
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
                        postList[index].incendios,
                        postList[index].municipio,
                      );
                    } else {
                      return Container();
                    }
                  })),
    );
  }

  Widget postsUI(
    String municipio,
    String incendios,
    String claveIGECEM,
  ) {
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
              Text("Incendios: " + incendios,
                  style: Theme.of(context).textTheme.subtitle2),
              SizedBox(height: 10),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class EditPublication extends StatefulWidget {
  String _imunicipio, _iincendios, _iclaveIGECEM;

  EditPublication(
    String municipio,
    String incendios,
    String claveIGECEM,
  ) {
    _imunicipio = municipio;
    _iincendios = incendios;
    _iclaveIGECEM = claveIGECEM;
  }
  @override
  _EditPublicationState createState() => _EditPublicationState(
        _imunicipio,
        _iincendios,
        _iclaveIGECEM,
      );
}

class _EditPublicationState extends State<EditPublication> {
  String _municipio, _incendios, _claveIGECEM;

  String _nimunicipio, _niincendios, _niclaveIGECEM;

  final formKey = GlobalKey<FormState>();

  _EditPublicationState(
    String imunicipio,
    String iincendios,
    String iclaveIGECEM,
  ) {
    _municipio = imunicipio;
    _incendios = iincendios;
    _claveIGECEM = iclaveIGECEM;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
            child: Column(
              children: <Widget>[
                Text("Este es el municipio",
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 15), //Define un espacio
                //Define un espacio

                Text("Incendios", style: Theme.of(context).textTheme.headline6),
                TextFormField(
                  decoration: InputDecoration(labelText: _incendios),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es requerido" : null;
                  },
                  onSaved: (value) {
                    return _incendios = value;
                  },
                  onChanged: (value) {
                    return _niincendios = value;
                  },
                ),
                SizedBox(height: 15),

                RaisedButton(
                    child: Text('¡Editar Municipio!'),
                    onPressed: uploadIncendio),
                //Define un espacio
              ],
            ),
          ),
        ),
      ),
    );
  }

  void uploadIncendio() async {
    saveToDatabase(_niincendios);

    Alert(
        context: context,
        title: "Incendio modificado correctamente",
        buttons: []).show();
  }

  void saveToDatabase(String url) {
    //Guardar el post: Titulo, descripcion, imagen, fecha, hora
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = {
      'altitud': _nimunicipio,
      'cabecera': _niincendios,
      'claveIGECEM': _niclaveIGECEM,
    };
    ref.child("Incendios").child(_incendios).set(data);
  }
}
