import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class ModificarMunicipio extends StatefulWidget {
  @override
  _ModificarMunicipio createState() => _ModificarMunicipio();
}

class _ModificarMunicipio extends State<ModificarMunicipio> {
  final formKey = GlobalKey<
      FormState>(); //Permite que los widgets cambien a padres sin perder su estado o acceder a info del arbol

  String _maltitud,
      _mcabecera,
      _mclaveIGECEM,
      _mclima,
      _mcuerposAgua,
      _melevaciones,
      _mlatitud,
      _mlongitud,
      _mmasExtensos,
      _mmasIndustrializados,
      _mmasPoblados,
      _mmenosExtensos,
      _mmunicipio,
      _mrios,
      _msignificado,
      _msuperficie,
      claveCompleta;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppBar(
                title: Text('Crear Municipio'),
                centerTitle: true,
              ),

              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: 'ClaveIGECEM'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _mclaveIGECEM = value;
                },
              ),
              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(labelText: 'Municipio'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _mmunicipio = value;
                },
              ),
              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(labelText: 'Singnificado'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _msignificado = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cabercera'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _mcabecera = value;
                },
              ),
              SizedBox(height: 15),

              SizedBox(height: 15),

              //Define un espacio
              TextFormField(
                decoration: InputDecoration(labelText: 'Superficie'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _msuperficie = value;
                },
              ),
              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(labelText: 'Altitud'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _maltitud = value;
                },
              ),
              SizedBox(height: 15), //Define un espacio

              TextFormField(
                decoration: InputDecoration(labelText: 'Elevaciones'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _melevaciones = value;
                },
              ),
              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(labelText: 'Ríos'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _mrios = value;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cuerpos de agua'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _mcuerposAgua = value;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: 'Población'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _mmasPoblados = value;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: ' Gran Extensión'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _mmasExtensos = value;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: 'Menor Extensión '),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _mmenosExtensos = value;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: 'Industrialización'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _mmasIndustrializados = value;
                },
              ),
              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(labelText: 'Clima'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _mclima = value;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: 'Latitud'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _mlatitud = value;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: 'Longitud'),
                validator: (value) {
                  return value.isEmpty ? "Este valor es necesario" : null;
                },
                onSaved: (value) {
                  return _mlongitud = value;
                },
              ),
              SizedBox(height: 15),
              RaisedButton(
                child: Text('Crear municipio'),
                onPressed: uploadMunicipio,
              ),
              SizedBox(height: 15) //Define un espacio
            ],
          ),
        ),
      ),
    ));
  }

  void uploadMunicipio() async {
    if (validateAndSave()) {
      saveMunicipio();
      Alert(
          context: context,
          title: "Municipio editado correctamente",
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

  void saveMunicipio() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "altitud": _maltitud,
      "cabecera": _mcabecera,
      "claveIGECEM": 'clave' + _mclaveIGECEM,
      "clima": _mclima,
      "cuerposAgua": _mcuerposAgua,
      "elevaciones": _melevaciones,
      "latitud": _mlatitud,
      "longitud": _mlongitud,
      "masExtensos": _mmasExtensos,
      "masIndustrializados": _mmasIndustrializados,
      "masPoblados": _mmasPoblados,
      "menosExtensos": _mmenosExtensos,
      "municipio": _mmunicipio,
      "rios": _mrios,
      "significado": _msignificado,
      "superficie": _msuperficie
    };
    ref.child("Municipios").child('clave' + _mclaveIGECEM).set(data);
  }
}
