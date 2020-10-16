import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/objects/municipios.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

String i,busqueda;
List<Municipios> postList = [];

class DesplayMunicipiosAdmin extends StatefulWidget {
  DesplayMunicipiosAdmin(String a, String busquedaux){
    i = a;
    busqueda = busquedaux;
  }


  @override
  _DesplayMunicipiosAdmin createState() => _DesplayMunicipiosAdmin();
  }

  
  class _DesplayMunicipiosAdmin  extends State<DesplayMunicipiosAdmin>{

  @override
  void initState(){
    super.initState();

    print("Valor:" + i + "Clave bsuqeda" + busqueda);
    
    DatabaseReference postsRef = FirebaseDatabase.instance.reference().child("Municipios");
    postsRef.once().then((DataSnapshot snap){
      //print('Data keys : ${snap.value.keys}');
      //print('Data value : ${snap.value}');
      var keys = snap.value.keys;
      var data = snap.value;
      postList.clear();
      for(var individualKey in keys){
        
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
        print('Largo: '+ postList.length.toString()); //tamaño de lista de posts
      });

    });
  }
  //INICIO DE BD
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Municipios Encontrados'), centerTitle: true,),
      body: 
      Container(//Aqui se deben mostrar las publicaciones
        child: postList.length == 0 ? Text("No hay Municipios") : ListView.builder(
          itemCount: postList.length,
          itemBuilder: (_,index){
            if(i=="1"){
                if(postList[index].claveIGECEM.toString() == "clave"+busqueda.toString() ){
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
                                            postList[index].masIndustralizados,
                                            postList[index].masExtensos,
                                            postList[index].elevaciones,
                                          );
                            }else{
                              return Container();
                            }
            }else{
              if(postList[index].municipio.toString().toUpperCase().contains(busqueda) ){
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
                            postList[index].masIndustralizados,
                            postList[index].masExtensos,
                            postList[index].elevaciones,
                          );
            }else{
              return Container();
            }
            }
          })
      ),



      ///CUESTIONES DE ESTETICA
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.all_out),
              title: Text('Todos'),
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              title: Text('Editar'),
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text('Nuevo'),
              backgroundColor: Colors.amber),
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

  Widget postsUI(String clave, String municipio, String cabecera, String significado, 
                 String altitud, String superficie, 
                 String clima, String latitud, String longitud,
                 String masPoblados, String cuerposAgua, String masIndustralizados, 
                 String masExtensos,String elevaciones){

    String descripcion = "";
    
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Container(
        margin: EdgeInsets.all(14),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/edomex.png'),height: 100,),
            SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Superficie:" + superficie,style: Theme.of(context).textTheme.subtitle2, textAlign: TextAlign.center,),
                Text("Altitud:" +altitud,style: Theme.of(context).textTheme.subtitle2, textAlign: TextAlign.center,)
              ],
            ),
            SizedBox(height:10),
            Text(clave.replaceFirst("clave", "Clave IGECEM: "), style: Theme.of(context).textTheme.subtitle1),
            Text(municipio, style: Theme.of(context).textTheme.headline4),
            SizedBox(height:2),
            Text('Cabecera: '+cabecera, style: Theme.of(context).textTheme.headline5),
            SizedBox(height:10),
            Text(significado.toString(), style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height:10),
            Text(clima, style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height:10),
            Text(elevaciones.startsWith("0") ? "No tiene elevaciones":elevaciones, style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height:10),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed:(){
                  print('Editar Municipio');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditMunicipio(clave,municipio,cabecera,significado,
                                                        superficie,altitud, latitud, longitud,clima,elevaciones,cuerposAgua),
                  ));
                }, icon: Icon(Icons.edit),),

                IconButton(onPressed:(){
                  print('Eliminar');
                  //ELIMINAR
                  DatabaseReference modifyPost = FirebaseDatabase.instance.reference().child("Municipios").child(clave);
                  modifyPost.remove();
                  Alert(context: context, 
                    title: "Municipio "+ municipio +" borrado adecuadamente",
                    desc: "Por favor actualiza la lista",
                    buttons: []
                  ).show();

                }, icon: Icon(Icons.delete),),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

// ignore: must_be_immutable
class EditMunicipio extends StatefulWidget{
  String newclave, newmunicipio, newcabecera, newsignificado, newsuperficie, newaltitud, newlatitud , newlongitud, newclima, newelevaciones, newcuerposAgua;

  EditMunicipio(String clave, String municipio, String cabecera, String significado, 
                String superficie, String altitud, String latitud,String longitud ,
                String clima, String elevaciones, String cuerposAgua){
    newclave = clave;
    newmunicipio = municipio;
    newcabecera = cabecera;
    newsignificado = significado;
    newsuperficie = superficie;
    newaltitud = altitud;
    newlatitud = latitud;
    newlongitud = longitud;
    newclima = clima;
    newelevaciones = elevaciones;
    newcuerposAgua = cuerposAgua;
  }

  
  @override
  _EditMunicipioState createState() => _EditMunicipioState(newclave, newmunicipio, newcabecera, newsignificado, newsuperficie,
                                                           newaltitud, newlatitud,newlongitud , newclima, newelevaciones, newcuerposAgua);

}

class _EditMunicipioState extends State<EditMunicipio> {
  String newclave, newmunicipio, newcabecera, newsignificado, newsuperficie, newaltitud, newlatitud,newlongitud, newclima, newelevaciones, newcuerposAgua;

  _EditMunicipioState(String clave1, String municipio1, String cabecera1, String significado1, String superficie1,
                      String altitud1, String latitud1, String longitud1, String clima1, String elevaciones1, String cuerposAgua1){
    newclave = clave1;
    newmunicipio = municipio1;
    newcabecera = cabecera1;
    newsignificado = significado1;
    newsuperficie = superficie1;
    newaltitud = altitud1;
    newlatitud = latitud1;
    newlongitud = longitud1;
    newclima = clima1;
    newelevaciones = elevaciones1;
    newcuerposAgua = cuerposAgua1;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Editando: ' + newmunicipio), centerTitle: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
          child: Column(
            children: <Widget>[
              Image(image: AssetImage('assets/edomex.png'),height: 100,),
              Text("¡Esta es la información del Estado!", style: Theme.of(context).textTheme.headline6),
              SizedBox(height:15), //Define un espacio 
              Text("Edita los datos", style: Theme.of(context).textTheme.headline6),
              SizedBox(height:45),

              Text("Nombre Municipio:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText: newmunicipio),
                initialValue: newmunicipio,
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
                decoration: InputDecoration(labelText: newcabecera),
                initialValue: newcabecera,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newcabecera = value;},
                onChanged: (value){return newcabecera = value;},
              ),
              SizedBox(height:15), 

              Text("Significado:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText: newsignificado),
                initialValue: newsignificado,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newsignificado = value;},
                onChanged: (value){return newsignificado = value;},
              ),
              SizedBox(height:15), 

              Text("Clima:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText: newclima),
                initialValue: newclima,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newclima = value;},
                onChanged: (value){return newclima = value;},
              ),
              SizedBox(height:15), 

              Text("Elevaciones:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText: newelevaciones.endsWith("0") ? "No hay elevaciones registradas" : newelevaciones),
                initialValue: newelevaciones,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newelevaciones = value;},
                onChanged: (value){return newelevaciones = value;},
              ),
              SizedBox(height:15),

              Text("Cuerpos agua:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText:newcuerposAgua.endsWith("0") ? "No hay cuerpo de agua registrado" : newcuerposAgua),
                initialValue: newcuerposAgua,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newcuerposAgua = value;},
                onChanged: (value){return newcuerposAgua = value;},
              ),
              SizedBox(height:15), 

              Text("Altitud:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText:newaltitud),
                initialValue: newaltitud,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newaltitud = value;},
                onChanged: (value){return newaltitud = value;},
              ),
              SizedBox(height:15), 

              Text("Latitud:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText:newlongitud),
                initialValue: newlongitud,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newlongitud = value;},
                onChanged: (value){return newlongitud = value;},
              ),
              SizedBox(height:15), 

              Text("Longitud:", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText:newlatitud),
                initialValue: newlatitud,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newlatitud = value;},
                onChanged: (value){return newlatitud = value;},
              ),
              SizedBox(height:15), 

              Text("Superficie (km²):", style: Theme.of(context).textTheme.subtitle1),
              TextFormField(
                decoration: InputDecoration(labelText:newsuperficie),
                initialValue: newsuperficie,
                validator: (value){return value.isEmpty ? "Falta dato..." : null;},
                onSaved: (value){return newsuperficie = value;},
                onChanged: (value){return newsuperficie = value;},
              ),
              SizedBox(height:15), 
              
              RaisedButton(
                child:Text('Editar Estado'),
                onPressed: uploadStatusImage
                ),
               //Define un espacio
            ],
          ),
        ),
        ),
      ),
      //Interfaz del navigation bar

      ///CUESTIONES DE ESTETICA
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.all_out),
              title: Text('Todos'),
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              title: Text('Editar'),
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text('Nuevo'),
              backgroundColor: Colors.amber),
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


  void uploadStatusImage()async{

    saveToDatabase(newmunicipio);

    //Regresar a la pantalla de feed
    Alert(context: context, 
      title: "Publicación editada correctamente",
      desc: "Refresca la pantalla para ver los cambios",
      buttons: []
    ).show();
  
}


void saveToDatabase(String url){
  //Guardar el post: Titulo, descripcion, imagen, fecha, hora


  DatabaseReference ref = FirebaseDatabase.instance.reference();

  print("Nuevos valores: " + newmunicipio + " " + newcabecera + " " + newclave + " " + newsignificado +" " + newclima + "");

  var data = {
    "altitud": newaltitud,
    "cabecera": newcabecera,
    "claveIGECEM": newclave,
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
  ref.child("Municipios").child(newclave).set(data);
  
  }
}
