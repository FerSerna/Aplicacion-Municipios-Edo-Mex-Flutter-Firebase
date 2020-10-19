import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CreateInundacion extends StatefulWidget {
  @override
  _CreateInundacion createState() => _CreateInundacion();
}

class _CreateInundacion extends State<CreateInundacion> {
  final formKey = GlobalKey<
      FormState>(); //Permite que los widgets cambien a padres sin perder su estado o acceder a info del arbol

  String _mclaveIGECEM,
      _mmunicipio,
      _mporcentajeSuceptabilidad,
      _msuperficie,
      _msuperficieSuseptible;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creando información sobre Inundación'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text('Capture la siguiente información',
                    style: Theme.of(context).textTheme.subtitle1),
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
                  decoration: InputDecoration(
                      labelText: 'Porcentaje de suceptibilidad'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _mporcentajeSuceptabilidad = value;
                  },
                ),
                SizedBox(height: 15),
                //Define un espacio
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Superficie Suceptible'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _msuperficieSuseptible = value;
                  },
                ),
                SizedBox(height: 15),

                RaisedButton(
                  child: Text('Subir información de inundación'),
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
      "claveIGECEM": 'clave' + _mclaveIGECEM,
      "municipio": _mmunicipio,
      "porcentajeSuceptibilidad": _mporcentajeSuceptabilidad,
      "superficie": _msuperficie,
      "superficieSuceptible": _msuperficieSuseptible,
    };
    ref.child("Inundaciones").child('clave' + _mclaveIGECEM).set(data);
  }
}
