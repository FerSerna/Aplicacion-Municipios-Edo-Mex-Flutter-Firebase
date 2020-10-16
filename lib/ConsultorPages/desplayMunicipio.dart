import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/objects/municipios.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'extras/localizacion.dart';

class DesplayMunicipios extends StatefulWidget {
  String i,busqueda;
  DesplayMunicipios(String i, String busqueda){
    this.i = i;
    this.busqueda = busqueda;
  }

  @override
  _DesplayMunicipio createState() => _DesplayMunicipio(i,busqueda);
}

class _DesplayMunicipio extends State<DesplayMunicipios> {

  //Definimos la lista de Posts
  List<Municipios> postList = [];
  String i,busqueda;

  _DesplayMunicipio(String i, String busqueda){
    this.i = i;
    this.busqueda = busqueda;
  }

  //Inicializamos database para jalar los posts
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
              icon: Icon(Icons.search),
              title: Text('Municipios'),
              backgroundColor: Colors.orange),
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
                 String masExtensos){

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
            Text(clave.replaceFirst("clave", "Clave IGECEM: "), style: Theme.of(context).textTheme.subtitle1),
            Text(municipio, style: Theme.of(context).textTheme.headline4),
            SizedBox(height:2),
            Text('Cabecera: '+cabecera, style: Theme.of(context).textTheme.headline5),
            SizedBox(height:10),
            Text(significado, style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height:10),
            
            SizedBox(height:10),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed:(){
                  print('Poblacion');
                  masPoblados.contains("0") ? descripcion="No hay sobrepoblacion \n\n " 
                                            : descripcion="Hay sobrepoblacion \n\n " + masPoblados;
                  Alert(context: context, 
                    title: "Poblacion de " + municipio,
                    desc: descripcion,
                    buttons: []
                  ).show();
                }, icon: Icon(Icons.people),),

                IconButton(onPressed:(){
                  print('Elevacion');
                  Alert(context: context, 
                    title: "Altitud de " + municipio,
                    desc: "Este municipio cuenta con una altitud de: " + altitud + "",
                    buttons: []
                  ).show();
                }, icon: Icon(Icons.upgrade),),

                IconButton(onPressed:(){
                  print('Rios');
                  cuerposAgua.contains("0") ? descripcion="Este municipio no contiene cuerpos de agua registrados" 
                                            : descripcion="Este municipio tiene los siguientes cuerpos de agua registrados: \n \n " + cuerposAgua ;
                  Alert(context: context, 
                    title: "Cuerpos de agua en " + municipio,
                    desc: descripcion,
                    buttons: []
                  ).show();
                }, icon: Icon(Icons.blur_circular_sharp),),
                
                IconButton(onPressed:(){
                  print('Nivel de Industrializacion');
                  masIndustralizados.contains("0") ? descripcion="Este municipio no cuenta con gran desarrollo industrial" 
                                            : descripcion="Este municipio posee un gran desarrollo industrial: \n \n" + masIndustralizados;
                  Alert(context: context, 
                    title: "Industrialización en " + municipio,
                    desc: descripcion,
                    buttons: []
                  ).show();
                }, icon: Icon(Icons.location_city),),

                IconButton(onPressed:(){
                  print('Extension');
                  masExtensos.contains("0") ? descripcion="Este municipio no contiene gran extensión territorial \n \n  " + "Su extension es: " + superficie 
                                            : descripcion="Este municipio es de los más extensos territorial \n \n " + "Su extension es: " + superficie;
                  Alert(context: context, 
                    title: "Superficie de " + municipio,
                    desc: descripcion,
                    buttons: []
                  ).show();
                }, icon: Icon(Icons.line_weight),),

                IconButton(onPressed:(){
                  print('Clima');
                  Alert(context: context, 
                    title: "Superficie de " + municipio,
                    desc: "El clima de este Municipio es: \n\n " + clima,
                    buttons: []
                  ).show();
                }, icon: Icon(Icons.wb_sunny),),

                IconButton(onPressed:(){
                  print('NOMBRE: '+ municipio +'  La:'+ longitud + "  " + "Lon:" + latitud);                  
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DesplayMapa(longitud,latitud),
                    ));
                }, icon: Icon(Icons.map),),

              ],
            ),

          ],
        ),
      ),
    );
  }
}