import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/objectsAdmin/municipios.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'coordenadas/localizacion.dart';

// ignore: must_be_immutable
class DesplayMunicipios extends StatefulWidget {
  String i, busqueda;
  DesplayMunicipios(String i, String busqueda) {
    this.i = i;
    this.busqueda = busqueda;
  }

  @override
  _DesplayMunicipio createState() => _DesplayMunicipio(i, busqueda);
}

class _DesplayMunicipio extends State<DesplayMunicipios> {
  //Definimos la lista de Posts
  List<Municipios> postList = [];
  String i, busqueda;
  final myController = TextEditingController();

  _DesplayMunicipio(String i, String busqueda) {
    this.i = i;
    this.busqueda = busqueda;
  }

  //Inicializamos database para jalar los posts
  @override
  void initState() {
    super.initState();

    print("Valor:" + i + "Clave bsuqeda" + busqueda);

    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Municipios");
    postsRef.once().then((DataSnapshot snap) {
      //print('Data keys : ${snap.value.keys}');
      //print('Data value : ${snap.value}');
      var keys = snap.value.keys;
      var data = snap.value;
      postList.clear();
      for (var individualKey in keys) {
        Municipios municipios = Municipios(
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
          data[individualKey]['superficie'],
        );
        postList.add(municipios);
      }

      setState(() {
        //tamaño de lista de posts
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Municipios '),
        centerTitle: true,
      ),
      body: Container(
          //Aqui se deben mostrar las publicaciones
          child: postList.length == 0
              ? Text("No hay Municipios")
              : ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (_, index) {
                    if (i == "1") {
                      if (postList[index].claveIGECEM.toString() ==
                          "clave" + busqueda.toString()) {
                        return postsUI(
                          postList[index].claveIGECEM,
                          postList[index].municipio,
                          postList[index].cabecera,
                          postList[index].significado,
                          postList[index].altitud,
                          postList[index].superficie,
                          postList[index].clima,
                          postList[index].latitud,
                          postList[index].longitud,
                          postList[index].masPoblados,
                          postList[index].cuerposAgua,
                          postList[index].rios,
                          postList[index].elevaciones,
                          postList[index].masIndustrializados,
                          postList[index].masExtensos,
                          postList[index].menosExtensos,
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      if (postList[index]
                          .municipio
                          .toString()
                          .toUpperCase()
                          .contains(busqueda)) {
                        return postsUI(
                          postList[index].claveIGECEM,
                          postList[index].municipio,
                          postList[index].cabecera,
                          postList[index].significado,
                          postList[index].altitud,
                          postList[index].superficie,
                          postList[index].clima,
                          postList[index].latitud,
                          postList[index].longitud,
                          postList[index].masPoblados,
                          postList[index].cuerposAgua,
                          postList[index].elevaciones,
                          postList[index].cuerposAgua,
                          postList[index].masIndustrializados,
                          postList[index].masExtensos,
                          postList[index].menosExtensos,
                        );
                      } else {
                        return Container();
                      }
                    }
                  })),
    );
  }

  Widget postsUI(
      String claveIGECEM,
      String municipio,
      String cabecera,
      String significado,
      String altitud,
      String superficie,
      String clima,
      String latitud,
      String longitud,
      String masPoblados,
      String cuerposAgua,
      String elevaciones,
      String rios,
      String masIndustralizados,
      String menosExtensos,
      String masExtensos) {
    String descripcion = "";
    String names = "";
    final _myController = TextEditingController();

    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Container(
        margin: EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(names),
            Image(
              image: AssetImage('assets/edomex.jpg'),
              height: 100,
            ),
            SizedBox(height: 10),
            Text(claveIGECEM.replaceFirst("clave", "Clave IGECEM: "),
                style: Theme.of(context).textTheme.subtitle1),
            Text(municipio, style: Theme.of(context).textTheme.headline4),
            SizedBox(height: 2),
            Text('Cabecera: ' + cabecera,
                style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 10),
            Text(significado, style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: 10),
            Text(altitud, style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: 10),
            Text(superficie, style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    print('Poblacion');
                    masPoblados.contains("0")
                        ? descripcion = "No hay sobrepoblacion \n\n "
                        : descripcion =
                            "Hay sobrepoblacion \n\n " + masPoblados;
                    Alert(
                        context: context,
                        title: "Poblacion de " + municipio,
                        desc: descripcion,
                        buttons: []).show();
                  },
                  icon: Icon(Icons.people),
                ),
                IconButton(
                  onPressed: () {
                    print('Elevaciones');
                    elevaciones.contains("0")
                        ? descripcion =
                            "Este municipio no contiene elevaciones registrados"
                        : descripcion =
                            "Este municipio tiene las siguientes elevaciones registradas: \n \n " +
                                elevaciones;
                    Alert(
                        context: context,
                        title: "Elevaciones en " + municipio,
                        desc: descripcion,
                        buttons: []).show();
                  },
                  icon: Icon(Icons.adjust),
                ),
                IconButton(
                  onPressed: () {
                    print('Cuerpos de agua');
                    cuerposAgua.contains("0")
                        ? descripcion =
                            "Este municipio no contiene cuerpos de agua registrados"
                        : descripcion =
                            "Este municipio tiene los siguientes cuerpos de agua registrados: \n \n " +
                                cuerposAgua;
                    Alert(
                        context: context,
                        title: "Cuerpos de agua en " + municipio,
                        desc: descripcion,
                        buttons: []).show();
                  },
                  icon: Icon(Icons.blur_circular_sharp),
                ),
                IconButton(
                  onPressed: () {
                    print('Rios');
                    rios.contains("0")
                        ? descripcion =
                            "Este municipio no contiene Ríos registrados"
                        : descripcion =
                            "Este municipio tiene los siguientes ríos registrados: \n \n " +
                                rios;
                    Alert(
                        context: context,
                        title: "Ríos en " + municipio,
                        desc: descripcion,
                        buttons: []).show();
                  },
                  icon: Icon(Icons.bar_chart),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    print('Nivel de Industrializacion');
                    masIndustralizados.contains("0")
                        ? descripcion =
                            "Este municipio no cuenta con gran desarrollo industrial"
                        : descripcion =
                            "Este municipio posee un gran desarrollo industrial: \n \n" +
                                masIndustralizados;
                    Alert(
                        context: context,
                        title: "Industrialización en " + municipio,
                        desc: descripcion,
                        buttons: []).show();
                  },
                  icon: Icon(Icons.location_city),
                ),
                IconButton(
                  onPressed: () {
                    print('Más extensos');
                    masExtensos.contains("0")
                        ? descripcion =
                            "Este municipio no se considera de los más extensos"
                        : descripcion =
                            "Este municipio se considera muy extenso: \n \n" +
                                masExtensos;
                    Alert(
                        context: context,
                        title: "Superficie de " + municipio,
                        desc: descripcion,
                        buttons: []).show();
                  },
                  icon: Icon(Icons.blur_linear),
                ),
                IconButton(
                  onPressed: () {
                    print('Menos extensos');
                    menosExtensos.contains("0")
                        ? descripcion =
                            "Este municipio no se considera de los menos extensos"
                        : descripcion =
                            "Este municipio se considera poco extenso: \n \n" +
                                menosExtensos;
                    Alert(
                        context: context,
                        title: "Superficie de " + municipio,
                        desc: descripcion,
                        buttons: []).show();
                  },
                  icon: Icon(Icons.line_weight),
                ),
                IconButton(
                  onPressed: () {
                    print('Clima');
                    Alert(
                        context: context,
                        title: "Superficie de " + municipio,
                        desc: "El clima de este Municipio es: \n\n " + clima,
                        buttons: []).show();
                  },
                  icon: Icon(Icons.wb_sunny),
                ),
                IconButton(
                  onPressed: () {
                    print('Municipio: ' +
                        municipio +
                        '  La:' +
                        longitud +
                        "  " +
                        "Lon:" +
                        latitud);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DesplayMapa(longitud, latitud),
                    ));
                  },
                  icon: Icon(Icons.map),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    print('Se modificará el municipio :' + claveIGECEM);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditMunicipio(
                          altitud,
                          cabecera,
                          claveIGECEM,
                          clima,
                          cuerposAgua,
                          elevaciones,
                          latitud,
                          longitud,
                          masExtensos,
                          masIndustralizados,
                          masPoblados,
                          menosExtensos,
                          municipio,
                          rios,
                          significado,
                          superficie),
                    ));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                ),
                /*
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CreateInundacion();
                    }));
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.orange,
                  ),
                ),
                */
                IconButton(
                    onPressed: () {
                      DatabaseReference modifyPost = FirebaseDatabase.instance
                          .reference()
                          .child("Municipios")
                          .child(claveIGECEM);
                      modifyPost.remove();
                      DatabaseReference modifyInundaciones = FirebaseDatabase
                          .instance
                          .reference()
                          .child("Inundaciones")
                          .child(claveIGECEM);
                      modifyInundaciones.remove();
                      DatabaseReference modifyIncendios = FirebaseDatabase
                          .instance
                          .reference()
                          .child("Incendios")
                          .child(claveIGECEM);
                      modifyIncendios.remove();
                      DatabaseReference modifyDeslaves = FirebaseDatabase
                          .instance
                          .reference()
                          .child("Deslaves")
                          .child(claveIGECEM);
                      modifyDeslaves.remove();
                      DatabaseReference modifySismos = FirebaseDatabase.instance
                          .reference()
                          .child("Zona Sismica")
                          .child(claveIGECEM);
                      modifySismos.remove();
                      DatabaseReference modifyVolcanes = FirebaseDatabase
                          .instance
                          .reference()
                          .child("Zona Volcanica")
                          .child(claveIGECEM);
                      modifyVolcanes.remove();
                      DatabaseReference modifyDerrumbes = FirebaseDatabase
                          .instance
                          .reference()
                          .child("Derrumbes")
                          .child(claveIGECEM);
                      modifyDerrumbes.remove();
                      Alert(
                          context: context,
                          title: "El municipio $municipio ha sido borrado ",
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
      ),
    );
  }
}

//..........................................................
//........AQUÍ COMIENZA LA MODIFICACION DE MUNICIPIO........
//..........................................................

// ignore: must_be_immutable
class EditMunicipio extends StatefulWidget {
  String _emaltitud,
      _emcabecera,
      _emclaveIGECEM,
      _emclima,
      _emcuerposAgua,
      _emelevaciones,
      _emlatitud,
      _emlongitud,
      _emmasExtensos,
      _emmasIndustrializados,
      _emmasPoblados,
      _emmenosExtensos,
      _emmunicipio,
      _emrios,
      _emsignificado,
      _emsuperficie;

  EditMunicipio(
      String altitud,
      String cabecera,
      String claveIGECEM,
      String clima,
      String cuerposAgua,
      String elevaciones,
      String latitud,
      String longitud,
      String masExtensos,
      String masIndustrializados,
      String masPoblados,
      String menosExtensos,
      String municipio,
      String rios,
      String significado,
      String superficie) {
    _emaltitud = altitud;
    _emcabecera = cabecera;
    _emclaveIGECEM = claveIGECEM;
    _emclima = clima;
    _emcuerposAgua = cuerposAgua;
    _emelevaciones = elevaciones;
    _emlatitud = latitud;
    _emlongitud = longitud;
    _emmasExtensos = masExtensos;
    _emmasIndustrializados = masIndustrializados;
    _emmasPoblados = masPoblados;
    _emmenosExtensos = menosExtensos;
    _emmunicipio = municipio;
    _emrios = rios;
    _emsignificado = significado;
    _emsuperficie = superficie;
  }

  @override
  _EditMunicipioState createState() => _EditMunicipioState(
      _emaltitud,
      _emcabecera,
      _emclaveIGECEM,
      _emclima,
      _emcuerposAgua,
      _emelevaciones,
      _emlatitud,
      _emlongitud,
      _emmasExtensos,
      _emmasIndustrializados,
      _emmasPoblados,
      _emmenosExtensos,
      _emmunicipio,
      _emrios,
      _emsignificado,
      _emsuperficie);
}

class _EditMunicipioState extends State<EditMunicipio> {
  String _altitud,
      _cabecera,
      _claveIGECEM,
      _clima,
      _cuerposAgua,
      _elevaciones,
      _latitud,
      _longitud,
      _masExtensos,
      _masIndustrializados,
      _masPoblados,
      _menosExtensos,
      _municipio,
      _rios,
      _significado,
      _superficie;

  String _nmaltitud,
      _nmcabecera,
      _nmclaveIGECEM,
      _nmclima,
      _nmcuerposAgua,
      _nmelevaciones,
      _nmlatitud,
      _nmlongitud,
      _nmmasExtensos,
      _nmmasIndustrializados,
      _nmmasPoblados,
      _nmmenosExtensos,
      _nmmunicipio,
      _nmrios,
      _nmsignificado,
      _nmsuperficie;

  final formKey = GlobalKey<FormState>();
  final _myController = TextEditingController();

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  _EditMunicipioState(
      emaltitud,
      emcabecera,
      emclaveIGECEM,
      emclima,
      emcuerposAgua,
      emelevaciones,
      emlatitud,
      emlongitud,
      emmasExtensos,
      emmasIndustrializados,
      emmasPoblados,
      emmenosExtensos,
      emmunicipio,
      emrios,
      emsignificado,
      emsuperficie) {
    _altitud = emaltitud;
    _cabecera = emcabecera;
    _claveIGECEM = emclaveIGECEM;
    _clima = emclima;
    _cuerposAgua = emcuerposAgua;
    _elevaciones = emelevaciones;
    _latitud = emlatitud;
    _longitud = emlongitud;
    _masExtensos = emmasExtensos;
    _masIndustrializados = emmasIndustrializados;
    _masPoblados = emmasPoblados;
    _menosExtensos = emmenosExtensos;
    _municipio = emmunicipio;
    _rios = emrios;
    _significado = emsignificado;
    _superficie = emsuperficie;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editando Municipio'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15),
                Text('IGECEM: ' + _claveIGECEM,
                    style: Theme.of(context).textTheme.subtitle2),
                TextFormField(
                  decoration: InputDecoration(labelText: ' Nueva Clave'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmclaveIGECEM = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Municipio: ' + _municipio,
                    style: Theme.of(context).textTheme.subtitle2),
                TextFormField(
                  //controller: _myController,
                  decoration: InputDecoration(labelText: ' Nuevo Municipio'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmmunicipio = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Significado: ' + _significado,
                    style: Theme.of(context).textTheme.subtitle2),
                TextFormField(
                  //controller: _myController,
                  decoration: InputDecoration(labelText: 'Nuevo singnificado'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmsignificado = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Cabecera: ' + _cabecera,
                    style: Theme.of(context).textTheme.subtitle2),
                TextFormField(
                  //controller: _myController,
                  decoration: InputDecoration(labelText: 'Nueva Cabercera'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmcabecera = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Superficie: ' + _superficie),
                //Define un espacio
                TextFormField(
                  //controller: _myController,
                  decoration: InputDecoration(labelText: 'Nueva Superficie'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmsuperficie = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Altitud: ' + _altitud),
                TextFormField(
                  //controller: _myController,
                  decoration: InputDecoration(labelText: 'Nueva altitud'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmaltitud = value;
                  },
                ),
                SizedBox(height: 15), //Define un espacio
                Text('Elevaciones:' + _elevaciones),
                TextFormField(
                  //controller: _myController,
                  decoration: InputDecoration(labelText: 'Nueva elevación'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmelevaciones = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Ríos: ' + _rios),
                TextFormField(
                  //controller: _myController,
                  decoration: InputDecoration(labelText: 'Nuevos Ríos'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmrios = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Cuerpos de agua: ' + _cuerposAgua),
                TextFormField(
                  //controller: _myController,
                  decoration:
                      InputDecoration(labelText: 'Nuevos Cuerpos de agua'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmcuerposAgua = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Status Población: ' + _masPoblados),
                TextFormField(
                  //controller: _myController,
                  decoration:
                      InputDecoration(labelText: 'Nuevo status población'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmmasPoblados = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Status Más Extensos: ' + _masExtensos),
                TextFormField(
                  //controller: _myController,
                  decoration:
                      InputDecoration(labelText: 'Nuevo Status Más Extensos'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmmasExtensos = value;
                  },
                ),
                SizedBox(height: 15),

                Text('Status Menos Extensos: ' + _menosExtensos),
                TextFormField(
                  // controller: _myController,
                  decoration:
                      InputDecoration(labelText: 'Nuevo Status Más Extensos'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmmenosExtensos = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Status Más Industrializados: ' + _masIndustrializados),
                TextFormField(
                  //controller: _myController,
                  decoration: InputDecoration(
                      labelText: 'Nuevo Status más industrializados'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmmasIndustrializados = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Clima:' + _clima),
                TextFormField(
                  //controller: _myController,
                  decoration: InputDecoration(labelText: 'Nuevo clima'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmclima = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Latitud:' + _latitud),
                TextFormField(
                  //controller: _myController,
                  decoration: InputDecoration(labelText: 'Nueva Latitud'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmlatitud = value;
                  },
                ),
                SizedBox(height: 15),
                Text('Longitud:' + _longitud),
                TextFormField(
                  //controller: _myController,
                  decoration: InputDecoration(labelText: 'Nueva Longitud'),
                  validator: (value) {
                    return value.isEmpty ? "Este valor es necesario" : null;
                  },
                  onSaved: (value) {
                    return _nmlongitud = value;
                  },
                ),
                SizedBox(height: 15),
                RaisedButton(
                  child: Text('Editar municipio'),
                  onPressed: uploadMunicipio,
                ),
                SizedBox(height: 15)
              ],
            ),
          ),
        ),
      ),
      //Interfaz del navigation bar
    );
  }

  void uploadMunicipio() async {
    if (validateAndSave()) {
      saveMunicipio();

      Alert(
          context: context,
          title: "Municipio creado correctamente",
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
      "altitud": _nmaltitud,
      "cabecera": _nmcabecera,
      "claveIGECEM": 'clave' + _nmclaveIGECEM,
      "clima": _nmclima,
      "cuerposAgua": _nmcuerposAgua,
      "elevaciones": _nmelevaciones,
      "latitud": _nmlatitud,
      "longitud": _nmlongitud,
      "masExtensos": _nmmasExtensos,
      "masIndustrializados": _nmmasIndustrializados,
      "masPoblados": _nmmasPoblados,
      "menosExtensos": _nmmenosExtensos,
      "municipio": _nmmunicipio,
      "rios": _nmrios,
      "significado": _nmsignificado,
      "superficie": _nmsuperficie
    };
    ref.child("Municipios").child('clave' + _nmclaveIGECEM).set(data);
  }
}
