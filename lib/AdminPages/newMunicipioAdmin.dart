import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class NewMunicipioAdmin extends StatefulWidget {

  @override
  _NewMunicipioAdmin createState() => _NewMunicipioAdmin();
    
  }
  
  class _NewMunicipioAdmin  extends State<NewMunicipioAdmin>{
  @override
  Widget build(BuildContext context) {
    String newclave, newmunicipio, newcabecera, newsignificado, newsuperficie, newaltitud, newlatitud , newlongitud, newclima, newelevaciones, newcuerposAgua;

    return Scaffold(
      appBar: AppBar(title:Text('Añadiendo Municipio'), centerTitle: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
          child: Column(
            children: <Widget>[
              Image(image: AssetImage('assets/edomex.png'),height: 100,),
              Text("¡Esta es la que tendrá el Municipio!", style: Theme.of(context).textTheme.headline6),
              SizedBox(height:15), //Define un espacio 
              Text("Llena los datos", style: Theme.of(context).textTheme.headline6),
              SizedBox(height:45),

              Text("Clave IGECEM:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText: "Ingresa la clave IGECEM"),
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newclave = value;},
                onChanged: (value){return newclave = value;},
              ),
              SizedBox(height:15), 

              Text("Nombre Municipio:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText: "Escribe nombre del Municipio"),
                validator: (value){
                  return value.isEmpty ? "Falta dato" : null;
                },
                onSaved: (value){
                  return newmunicipio = value;
                },
                onChanged: (value){
                  return newmunicipio = value;
                },
              ),
              SizedBox(height:15), 

              Text("Cabecera:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText: "Añade la cabecera"),
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newcabecera = value;},
                onChanged: (value){return newcabecera = value;},
              ),
              SizedBox(height:15), 

              Text("Significado:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText: "Da un significado"),
                initialValue: newsignificado,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newsignificado = value;},
                onChanged: (value){return newsignificado = value;},
              ),
              SizedBox(height:15), 

              Text("Clima:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText: "Elige su clima"),
                initialValue: newclima,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newclima = value;},
                onChanged: (value){return newclima = value;},
              ),
              SizedBox(height:15), 

              Text("Elevaciones:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText: "Describe sus elevaciones"),
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newelevaciones = value;},
                onChanged: (value){return newelevaciones = value;},
              ),
              SizedBox(height:15),

              Text("Cuerpos agua:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText:"Describe sus cuerpos de agua"),
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newcuerposAgua = value;},
                onChanged: (value){return newcuerposAgua = value;},
              ),
              SizedBox(height:15), 

              Text("Altitud:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText:"Ingresa la Altitud del municipio (m.s.n.m)"),
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newaltitud = value+"m.s.n.m";},
                onChanged: (value){return newaltitud = value+"m.s.n.m";},
              ),
              SizedBox(height:15), 

              Text("Latitud:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText:"Ingresa la Latitud"),
                initialValue: newlongitud,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newlongitud = value;},
                onChanged: (value){return newlongitud = value;},
              ),
              SizedBox(height:15), 

              Text("Longitud:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText:"Ingresa la Longitud"),
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newlatitud = value;},
                onChanged: (value){return newlatitud = value;},
              ),
              SizedBox(height:15), 

              Text("Superficie (km²):", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText:"Ingresa la superficie del Municipio (km²)"),
                initialValue: newsuperficie,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newsuperficie = value+"km²";},
                onChanged: (value){return newsuperficie = value+"km²";},
              ),
              SizedBox(height:15), 
              
              RaisedButton(
                child:Text('Añadir Municipio'),
                onPressed: (){
                    Alert(context: context, 
                    title: "Municipio añadido correctamente",
                    desc: "Refresca la pantalla para ver los cambios",
                    buttons: []
                  ).show();

                    DatabaseReference ref = FirebaseDatabase.instance.reference();
                    print("Nuevos valores: " + newmunicipio + " " + newcabecera + " " + newclave + " " + newsignificado +" " + newclima + "");
                    var data = {
                      "altitud": newaltitud,
                      "cabecera": newcabecera,
                      "claveIGECEM": "clave"+newclave,
                      "clima": newclima,
                      "cuerposAgua": newcuerposAgua,
                      "elevaciones": newelevaciones,
                      "latitud":newlatitud,
                      "longitud":newlongitud,
                      "masExtensos":"0",
                      "masIndustralizados":"0",
                      "masPoblados":"0",
                      "menosExtensos":"0",
                      "municipio":newmunicipio,
                      "rios":"0",
                      "significado":newsignificado,
                      "superficie":newsuperficie,
                    };
                    ref.child("Municipios").child("clave"+newclave).set(data);
                 }
                ),
               //Define un espacio
            ],
          ),
        ),
        ),
      ),
      //Interfaz del navigation bar
    );
  }

}