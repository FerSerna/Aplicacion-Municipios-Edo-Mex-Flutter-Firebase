import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/AdminActions/desplayMunicipios.dart';
import 'package:infoedomex/objectsAdmin/inundaciones.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
        Alert(
            context: context,
            title: "Municipios con Inundaciones",
            desc: postList.length.toString() + ' registrados',
            buttons: []).show();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Con peligro de Inundacion'),
        centerTitle: true,
      ),
      body: Container(
          //Aqui se deben mostrar las publicaciones
          child: postList.length == 0
              ? Text("No hay inundaciones")
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
                  'Superficie Suceptible a Inundaciones: \n' +
                      superficieSuseptible,
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
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
                        String clave = claveIGECEM.replaceAll("clave", "id_inund");
                        DatabaseReference modifyPost = FirebaseDatabase.instance
                            .reference()
                            .child("Inundaciones")
                            .child(clave);
                        modifyPost.remove();
                        Alert(
                            context: context,
                            title:
                                "Ha sido borrada la inundación en $municipio",
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

// ignore: must_be_immutable
class EditInundaciones extends StatefulWidget {
  String _eIclaveIGECEM,
      _eImunicipio,
      _eIporcentajeSuceptabilidad,
      _eIsuperficie,
      _eIsuperficieSuseptible;

  EditInundaciones(
      String claveIGECEM,
      String municipio,
      String porcentajeSuceptabilidad,
      String superficie,
      String superficieSuceptible) {
    _eIclaveIGECEM = claveIGECEM;
    _eImunicipio = municipio;
    _eIporcentajeSuceptabilidad = porcentajeSuceptabilidad;
    _eIsuperficie = superficie;
    _eIsuperficieSuseptible = superficieSuceptible;
  }

  @override
  _EditInundacionesState createState() => _EditInundacionesState(
      _eIclaveIGECEM,
      _eImunicipio,
      _eIporcentajeSuceptabilidad,
      _eIsuperficie,
      _eIsuperficieSuseptible);
}

class _EditInundacionesState extends State<EditInundaciones> {
  String _claveIGECEM,
      _municipio,
      _porcentajeSuceptibilidad,
      _superficie,
      _superficieSuceptibilidad;

  String _nIclaveIGECEM,
      _nImunicipio,
      _nIporcentajeSuceptibilidad,
      _nIsuperficie,
      _nIsuperficieSuceptibilidad;

  final formKey = GlobalKey<FormState>();

  _EditInundacionesState(
      String eIclaveIGECEM,
      String eImunicipio,
      String eIporcentajeSuceptabilidad,
      String eIsuperficie,
      String eIsuperficieSuseptible);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editando información sobre Inundación'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text('Capture la siguiente información',
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 15),
                Text('IGECEM: ' + _claveIGECEM,
                    style: Theme.of(context).textTheme.subtitle2),
                TextFormField(
                  decoration: InputDecoration(labelText: 'ClaveIGECEM'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nIclaveIGECEM = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Municipio: ' + _municipio,
                    style: Theme.of(context).textTheme.subtitle2),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Municipio'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nImunicipio = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Superficie: ' + _superficie,
                    style: Theme.of(context).textTheme.subtitle2),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Superficie'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nIsuperficie = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Porcentaje Suceptibilidad: ' + _porcentajeSuceptibilidad,
                    style: Theme.of(context).textTheme.subtitle2),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Porcentaje de suceptibilidad'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nIporcentajeSuceptibilidad = value;
                  },
                ),
                SizedBox(height: 15),
                //Define un espacio
                Text('Superficie Suceptible: ' + _superficieSuceptibilidad,
                    style: Theme.of(context).textTheme.subtitle2),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Superficie Suceptible'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nIsuperficieSuceptibilidad = value;
                  },
                ),
                SizedBox(height: 15),

                RaisedButton(
                  child: Text('Actualizar información de inundación'),
                  color: Colors.orange,
                  onPressed: uploadInundacion,
                ),
                SizedBox(height: 15) //Define un espacio
              ],
            ),
          ),
        ),
      ),
      //Interfaz del navigation bar
    );
  }

  void uploadInundacion() async {
    if (validateAndSave()) {
      saveInundacion();
      Alert(
          context: context,
          title: "Información creada correctamente",
          buttons: []).show();
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void saveInundacion() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "claveIGECEM": 'clave' + _nIclaveIGECEM,
      "municipio": _nImunicipio,
      "porcentajeSuceptibilidad": _nIporcentajeSuceptibilidad,
      "superficie": _nIsuperficie,
      "superficieSuceptible": _nIsuperficieSuceptibilidad,
    };
    ref.child("Inundaciones").child('clave' + _nIclaveIGECEM).set(data);
  }
}
